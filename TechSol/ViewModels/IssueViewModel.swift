import FirebaseFirestore
import Foundation

class IssueViewModel: ObservableObject {
    @Published var issues: [Issue] = []
    private var db = Firestore.firestore()

    init() {
        fetchIssues()
    }

    // ✅ Fetch issues from Firestore
    func fetchIssues() {
        db.collection("issues").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("❌ No issues found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.issues = documents.compactMap { doc in
                    var issue = try? doc.data(as: Issue.self)
                    issue?.reportId = doc.documentID // ✅ Ensure ID is correctly mapped
                    return issue
                }.compactMap { $0 }
            }
            print("✅ Fetched \(self.issues.count) issues from Firestore.")
        }
    }

    // ✅ Save issue to Firestore under `issues` collection
    func addIssue(equipmentId: String, reportedBy: String, assignedStudent: String, description: String) {
        let newIssue = Issue(
            reportId: UUID().uuidString,
            equipmentId: equipmentId,
            reportedBy: reportedBy,
            assignedStudent: assignedStudent,
            status: "open",
            description: description,
            timestamp: Date()
        )

        do {
            _ = try db.collection("issues").document(newIssue.reportId).setData([
                "reportId": newIssue.reportId,
                "equipmentId": newIssue.equipmentId,
                "reportedBy": newIssue.reportedBy,
                "assignedStudent": newIssue.assignedStudent,
                "status": newIssue.status,
                "description": newIssue.description,
                "timestamp": newIssue.timestamp
            ])
            print("✅ Issue reported successfully in Firestore!")
            fetchIssues() // ✅ Refresh issues after adding
        } catch {
            print("❌ Failed to add issue: \(error.localizedDescription)")
        }
    }
    
    // ✅ Mark an issue as solved (Deletes it from Firestore)
    func markIssueAsSolved(issueId: String) {
        db.collection("issues").document(issueId).delete { error in
            if let error = error {
                print("❌ Failed to delete issue: \(error.localizedDescription)")
            } else {
                print("✅ Issue \(issueId) marked as solved and removed from Firestore.")
                self.fetchIssues() // ✅ Refresh issues after deletion
            }
        }
    }
}
