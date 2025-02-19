import SwiftUI

struct EquipmentSelectionView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @Binding var selectedEquipment: InventoryItem?

    var body: some View {
        NavigationView {
            List(inventoryViewModel.inventoryItems) { item in
                Button(action: {
                    selectedEquipment = item
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("ID: \(item.id?.suffix(5) ?? "Unknown")") // ✅ Short ID
                                .font(.headline)
                            Text(item.type.joined(separator: ", ")) // ✅ Show type
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if selectedEquipment?.id == item.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(5)
                }
            }
            .navigationTitle("Select Equipment")
        }
    }
}
