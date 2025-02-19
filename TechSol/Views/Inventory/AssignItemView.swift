import SwiftUI

struct AssignItemView: View {
    var item: InventoryItem

    var body: some View {
        VStack {
            Text("Assign Equipment")
                .font(.title2)
                .fontWeight(.bold)

            Text("Equipment ID: \(item.id ?? "Unknown")") // ✅ Use `id` instead of `equipmentId`
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationTitle("Assign Item")
    }
}
