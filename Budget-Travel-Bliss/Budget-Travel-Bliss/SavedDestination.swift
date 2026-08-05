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

    init(from d: Destination) {
        self.destinationID = d.id
        self.name = d.name
        self.country = d.country
        self.dailyCost = d.dailyCost
        self.photo = d.photo
        self.savedAt = Date()
    }
}
