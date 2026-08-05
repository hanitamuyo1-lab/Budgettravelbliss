import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct BudgetTravelBlissApp: App {
    init() {
        MobileAds.shared.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SavedDestination.self)
    }
}
