import Foundation

struct StudentInfo: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var className: String
    var batch: String
    var scheduleId: String? // ✅ Add scheduleId to fix the error
}
