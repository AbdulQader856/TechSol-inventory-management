import Foundation

struct InventoryItem: Identifiable, Codable {
    var id: String? // Firestore Document ID (Equipment ID)
    var type: [String] // "Computer", "Mouse", "Keyboard"
    var brand: String // Brand name
    var status: [String] // "available", "assigned", "damaged"
    var assignedTo: AssignedStudent? // Nullable if not assigned

    struct AssignedStudent: Codable {
        var studentId: String
        var scheduleId: String
    }
}
