import Foundation

struct Schedule: Identifiable, Codable {
    var id: String? // Firestore Document ID
    var scheduleId: String // Unique Schedule ID
    var lab: [String] // ✅ Changed to array ["Lab 1", "Lab 2"]
    var className: [String] // ✅ Changed to array ["MCA 1st Sem", "MCA 3rd Sem"]
    var batch: [String] // ✅ Changed to array ["A", "B"]
    var days: [String] // ["Monday", "Tuesday"]
    var timeSlot: String // "10:00 AM - 12:00 PM"
}
