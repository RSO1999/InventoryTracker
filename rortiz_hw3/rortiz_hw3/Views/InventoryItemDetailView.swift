
// InventoryItemDetailView.swift

import SwiftUI

// Shows details for one item (read-only)
// - Just displays data, no editing logic here
struct InventoryItemDetailView: View {
    let item: InventoryItemModel // <-- THIS RECEIVES THE DATA FROM NAVIGATIONLINK

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {
            Group {
                Text(item.name)
                    .font(.title)
                    .bold()
                Text(item.location)
                    .font(.headline)
                    .italic()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Description")
                    .font(.headline)
                Text(item.description)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            
            HStack(spacing: 3) {
                Text("Quantity:")
                    .font(.headline)
                Text("\(item.quantity)")
                    .font(.body)
            }
            
            HStack(spacing: 4) {
                Text("Price:")
                    .font(.headline)
                Text(String(format: "$%.2f", item.price))
                    .font(.body)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Item Details")
    }
}


