import FirebaseFirestore
import Foundation

class InventoryViewModel: ObservableObject {
    @Published var inventoryItems: [InventoryItem] = []
    private var db = Firestore.firestore()

    init() {
        fetchInventory()
    }

    func fetchInventory() {
        db.collection("inventory").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("❌ No inventory items found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.inventoryItems = documents.map { doc in
                    var item = try? doc.data(as: InventoryItem.self)
                    item?.id = doc.documentID // ✅ Assign Firestore document ID
                    return item
                }.compactMap { $0 }
            }
            print("✅ Inventory fetched: \(self.inventoryItems.count) items")
        }
    }

    func addInventoryItem(item: InventoryItem) {
        let documentId = item.id ?? UUID().uuidString
        var data: [String: Any] = [
            "type": item.type,
            "brand": item.brand,
            "status": item.status
        ]

        if let assignedTo = item.assignedTo {
            data["assignedTo"] = [
                "studentId": assignedTo.studentId,
                "scheduleId": assignedTo.scheduleId
            ]
        }

        db.collection("inventory").document(documentId).setData(data) { error in
            if let error = error {
                print("🔥 Error adding inventory item: \(error.localizedDescription)")
            } else {
                print("✅ Inventory item added successfully!")
                self.fetchInventory() // ✅ Refresh UI after adding
            }
        }
    }
}
