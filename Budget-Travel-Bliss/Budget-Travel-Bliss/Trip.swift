import Foundation
import SwiftData

@Model
final class Trip {
    var destinationName: String
    var country: String
    var days: Int
    var style: String
    var total: Int
    var createdAt: Date

    init(destinationName: String, country: String, days: Int, style: String, total: Int) {
        self.destinationName = destinationName
        self.country = country
        self.days = days
        self.style = style
        self.total = total
        self.createdAt = Date()
    }
}
