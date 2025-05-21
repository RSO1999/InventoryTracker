
//  InventoryItemViewModel.swift


import Foundation

import Combine

// Manages the list of items
// - `ObservableObject` lets SwiftUI know when data changes
// - All the adding/deleting logic is handeled here


class InventoryItemViewModel: ObservableObject {
    //Hardcoded for demonstration purposes
    @Published var items: [InventoryItemModel] = [
        InventoryItemModel(name: "Couch", location: "Living Room", description: "Charcoal gray couch from Wayfair.", quantity: 1, price: 450.00),
        InventoryItemModel(name: "Dining Table", location: "Dining Room", description: "Wooden dining table with 6 chairs.", quantity: 1, price: 800.00),
        InventoryItemModel(name: "Laptop", location: "Bedroom", description: "MacBook Pro", quantity: 1, price: 2500.00),
        InventoryItemModel(name: "Bookshelf", location: "Bedroom", description: "Dark brown 5-tier wooden shelf.", quantity: 1, price: 120.00),
        InventoryItemModel(name: "Guitar", location: "Bedroom", description: "Blue Les Paul.", quantity: 1, price: 650.00),
        InventoryItemModel(name: "Refrigerator", location: "Kitchen", description: "Stainless steel double-door fridge.", quantity: 1, price: 1500.00),
        InventoryItemModel(name: "Television", location: "Living Room", description: "55-inch 4K TV.", quantity: 1, price: 1200.00),
        InventoryItemModel(name: "Desk Chair", location: "Home Office", description: "Leather office chair.", quantity: 1, price: 200.00),
        InventoryItemModel(name: "Bed Frame", location: "Bedroom", description: "Queen size wooden bed frame.", quantity: 1, price: 400.00),
    ]

    func addItem(name: String, location: String, description: String, quantity: Int, price: Double) {
        let newItem = InventoryItemModel(  name: name,
                                                             location: location,
                                                             description: description,
                                                             quantity: quantity,
                                                             price: price                      )
        
        items.append(newItem)
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        
        print("Remaining Items:")
        for item in items {
            print(item.name)
        }
    }
}

