import SwiftUI
import WebKit

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

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            WebView()
        }
    }
}
