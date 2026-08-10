import SwiftUI
import WebKit
import GoogleMobileAds

struct WebView: UIViewRepresentable {

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.bounces = false
        webView.scrollView.bouncesZoom = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        // Bottom inset so the page footer can scroll clear of the floating tab bar.
        webView.scrollView.contentInset.bottom = 95
        webView.scrollView.alwaysBounceHorizontal = false
        webView.scrollView.isDirectionalLockEnabled = true
        webView.isOpaque = false
        webView.backgroundColor = UIColor.black
        webView.scrollView.backgroundColor = UIColor.black

        // Load as string with production base URL so all HTTPS requests
        // (Supabase, GitHub raw image CDN) pass CORS checks properly.
        if let url = Bundle.main.url(forResource: "index", withExtension: "html"),
           let html = try? String(contentsOf: url, encoding: .utf8) {
            webView.loadHTMLString(html, baseURL: URL(string: "https://www.budget-travel-bliss.com"))
        }

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}

struct AdBanner: UIViewRepresentable {

    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner)
        banner.adUnitID = "ca-app-pub-1336217267927170/9454263274"
        banner.delegate = context.coordinator
        return banner
    }

    // The window isn't attached yet when makeUIView runs, so rootViewController
    // is resolved here and the request fires once it's available.
    func updateUIView(_ uiView: BannerView, context: Context) {
        guard uiView.rootViewController == nil else { return }
        guard let root = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController else { return }

        uiView.rootViewController = root

        // npa=1 requests non-personalized ads, which keeps the app out of
        // App Tracking Transparency territory.
        let request = Request()
        let extras = Extras()
        extras.additionalParameters = ["npa": "1"]
        request.register(extras)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("AdMob: banner loaded")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("AdMob: banner failed — \(error.localizedDescription)")
        }
    }
}

struct ExploreView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            WebView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            TabView {
                ExploreView()
                    .ignoresSafeArea()
                    .tabItem { Label("Explore", systemImage: "globe") }

                DestinationsView()
                    .tabItem { Label("Destinations", systemImage: "map") }

                SavedView()
                    .tabItem { Label("Saved", systemImage: "heart") }
            }
            // Persistent banner pinned above the tab bar so it's always visible.
            AdBanner()
                .frame(width: 320, height: 50)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
        }
    }
}
