
//  AddInventoryItemView.swift
import SwiftUI


// Form for adding new items
// - Uses `@State` to track form inputs
// - Validates inputs

struct AddInventoryItemView: View {
    
    // Connects to data manager
    // AddInventoryItemView declares it needs a viewModel with @ObservedObject
    @ObservedObject var viewModel: InventoryItemViewModel

    @State private var name: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var quantity: Int = 1
    @State private var price: Double = 0

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            
            // TextFields with character limit (20 max)

            Section(header: Text("Name")) {
                TextField("Enter Item's Name", text: Binding(
                    get: { name },
                    set: { newValue in
                        if newValue.count <= 20 {
                            name = newValue
                        }
                    }
                ))
            }

            Section(header: Text("Location")) {
                TextField("Enter Item's Location", text: Binding(
                    get: { location },
                    set: { newValue in
                        if newValue.count <= 20 {
                            location = newValue
                        }
                    }
                ))
            }
            // Shows character count (200 max for description)

            Section(header: Text("Description")) {
                TextEditor(text: Binding(
                    get: { description },
                    set: { newValue in
                        if newValue.count <= 200 {
                            description = newValue
                        }
                    }
                ))
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))

                Text("\(description.count)/200 characters")
                    .font(.caption)
                    .foregroundColor(description.count == 200 ? .red : .gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }


            Section(header: Text("Quantity")) {
                Stepper(value: $quantity, in: 1...1000) {
                    Text("\(quantity)")
                }
            }

            Section(header: Text("Price")) {
                VStack(alignment: .leading) {
                    Text("$\(price, specifier: "%.2f")")
                    Slider(value: $price, in: 0...1000, step: 1)
                }
            }

            Section {
                // "Add Item" button (disabled if form is invalid)
                Button("Add Item") {
                    viewModel.addItem(
                        name: name,
                        location: location,
                        description: description,
                        quantity: quantity,
                        price: price
                    )
                    presentationMode.wrappedValue.dismiss()
                }
                // Prevents invalid forms
                .disabled(name.isEmpty || quantity <= 0 || price < 0)
            }
        }
        .navigationTitle("Add Item")
    }
}
