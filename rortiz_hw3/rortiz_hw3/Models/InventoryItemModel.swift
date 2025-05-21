
//  InventoryItemModel.swift

// Represents an item in our inventory
// - Uses `Identifiable` so SwiftUI can track items in lists
// - `Hashable` lets us compare items easily (wasn't used)
import Foundation

struct InventoryItemModel: Identifiable, Hashable {
    let id = UUID() //UNIQUE IDS FOR EACH ITEMS
    var name: String
    var location: String
    var description: String
    var quantity: Int
    var price: Double
}
