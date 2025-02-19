import Foundation

struct Issue: Identifiable, Codable {
    var id: String { reportId } // ✅ Firestore Document ID
    var reportId: String
    var equipmentId: String
    var reportedBy: String
    var assignedStudent: String
    var status: String // "open" | "resolved"
    var description: String
    var timestamp: Date
}
