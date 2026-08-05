import Foundation

struct Destination: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let country: String
    let region: String
    let badge: String
    let tagline: String
    let dailyCost: Int
    let rating: Double
    let reviews: Int
    let photo: String
    let currency: String
    let bestTime: String
    let climate: String
    let lang: String
}

enum DestinationStore {
    // Loaded from the bundled JSON, so the list works with no network.
    static let all: [Destination] = {
        guard let url = Bundle.main.url(forResource: "destinations", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Destination].self, from: data) else {
            return []
        }
        return decoded
    }()

    static let regions: [String] = ["All"] + Array(Set(all.map(\.region))).sorted()
}
