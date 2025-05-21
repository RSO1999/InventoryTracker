
//InventoryListView.swift

import SwiftUI

// Main screen: shows the full inventory list
// - Uses `@StateObject` to keep the ViewModel alive
// - Handles sorting + deletion
struct InventoryListView: View {
    @StateObject private var viewModel = InventoryItemViewModel() // data manager
    @State private var isNewestItems: Bool = false
    
    // For delete functionality
    @State private var showDeleteConfirmation = false
    @State private var deleteOffsets: IndexSet? = nil


    var body: some View {
        NavigationView {
            VStack {
                Toggle("Sort By Newest Items", isOn: $isNewestItems)
                //Toggle button styling
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .padding()
                    .background(Color(.systemGray3))
                    .cornerRadius(10)
                    .padding(.horizontal)

                List {
                    //(for each) if true/toggled reverse item list
                    ForEach(isNewestItems ? viewModel.items.reversed() : viewModel.items) { item in
                        NavigationLink(destination: InventoryItemDetailView(item: item)) {
                            VStack(alignment: .leading, spacing: 6) {
                                //Items Styling
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(item.location)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            //Highlighting box styling
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray4).opacity(0.2))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadius(30)
                        }// end nav link
                        .listRowBackground(Color.clear)
                    } // end for each
                    
                    // Delete functionality
                    .onDelete { offsets in
                        // Show confirmation before deleting
                        deleteOffsets = offsets
                        showDeleteConfirmation = true
                    }

                } //end of list block
                .listStyle(PlainListStyle())
            } 
            .navigationTitle("Inventory Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: EditButton().foregroundColor(.blue),
                trailing:
                    // Passes viewModel to new view so it has access to the same data.
                    NavigationLink("Add Item", destination: AddInventoryItemView(viewModel: viewModel))
                        .foregroundColor(.blue)
            )
            
            .background(Color.black.edgesIgnoringSafeArea(.all))
            // Alert for delete confirmation
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Item"),
                    message: Text("Are you sure you want to delete this item?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let offsets = deleteOffsets {
                            viewModel.deleteItem(at: offsets)
                            deleteOffsets = nil
                        }
                    },
                    secondaryButton: .cancel {
                        deleteOffsets = nil
                    }
                )
            }//End Alert Block

        }
        .preferredColorScheme(.dark)
        
        //Used to prevent newly added items from going to the beginning when user adds an item.
        .onDisappear {
            isNewestItems = false
        }
    }
}

struct InventoryListView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryListView()
    }
}
