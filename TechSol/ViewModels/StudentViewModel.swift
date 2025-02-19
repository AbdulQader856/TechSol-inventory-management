import FirebaseFirestore
import Foundation

class StudentViewModel: ObservableObject {
    @Published var students: [StudentInfo] = []
    private var db = Firestore.firestore()

    init() {
        fetchStudents()
    }

    func fetchStudents() {
        db.collection("students").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No students found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.students = documents.compactMap { doc in
                    try? doc.data(as: StudentInfo.self)
                }
            }
        }
    }

    func addStudent(name: String, className: String, batch: String, scheduleId: String?) {
        let newStudent = StudentInfo(
            id: UUID().uuidString,
            name: name,
            className: className,
            batch: batch,
            scheduleId: scheduleId
        )

        let studentRef = db.collection("students").document(newStudent.id)
        
        studentRef.setData([
            "id": newStudent.id,
            "name": newStudent.name,
            "className": newStudent.className,
            "batch": newStudent.batch,
            "scheduleId": newStudent.scheduleId ?? ""
        ]) { error in
            if let error = error {
                print("🔥 Error adding student: \(error.localizedDescription)")
            } else {
                print("✅ Student added successfully!")
                self.fetchStudents() // ✅ Refresh UI after adding
            }
        }
    }
    
    // ✅ Get student name by ID
    func getStudentName(for studentId: String?) -> String? {
        guard let studentId = studentId else { return nil }
        return students.first(where: { $0.id == studentId })?.name
    }
}
