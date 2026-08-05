import Foundation
import SwiftData

@Model
final class SavedDestination {
    @Attribute(.unique) var destinationID: Int
    var name: String
    var country: String
    var dailyCost: Int
    var photo: String
    var savedAt: Date

    var photoURL: URL? {
        if photo.hasPrefix("http") {
            return URL(string: photo)
        }
        return URL(string: "https://images.unsplash.com/photo-\(photo)?auto=format&fit=crop&w=800&q=75")
    }

    init(from d: Destination) {
        self.destinationID = d.id
        self.name = d.name
        self.country = d.country
        self.dailyCost = d.dailyCost
        self.photo = d.photo
        self.savedAt = Date()
    }
}
