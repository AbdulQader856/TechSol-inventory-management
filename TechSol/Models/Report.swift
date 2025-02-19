import Foundation

struct Report: Identifiable, Codable {
    var id: String? // Firestore Document ID
    var reportId: String // Unique Report ID
    var equipmentId: String // Matches the primary key from Inventory
    var reportedBy: String // Who reported it
    var status: String // "Pending" or "Resolved"
    var description: String // Issue description
    var timestamp: Date // Time of report

    init(id: String? = nil, reportId: String, equipmentId: String, reportedBy: String, status: String = "Pending", description: String) {
        self.id = id
        self.reportId = reportId
        self.equipmentId = equipmentId
        self.reportedBy = reportedBy
        self.status = status
        self.description = description
        self.timestamp = Date()
    }
}
