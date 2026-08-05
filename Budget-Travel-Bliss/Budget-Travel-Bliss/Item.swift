//
//  Item.swift
//  Budget-Travel-Bliss
//
//  Created by Annie Mumba on 25/06/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
