import SwiftUI
import FirebaseFirestore

struct AddStudentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var studentViewModel = StudentViewModel()

    @State private var name = ""
    @State private var selectedClass = "MCA 1st Semester"
    @State private var selectedBatch = "A"
    @State private var scheduleId: String? = nil // ✅ Store scheduleId
    @State private var isViewingStudents = false // ✅ Toggle for Student List

    let classOptions = ["MCA 1st Semester", "MCA 2nd Semester", "MCA 3rd Semester"]
    let batchOptions = ["A", "B"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add New Student")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)

                VStack(spacing: 15) {
                    TextField("Enter Student Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(height: 50)

                    Picker("Select Class", selection: $selectedClass) {
                        ForEach(classOptions, id: \.self) { Text($0) }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)

                    Picker("Select Batch", selection: $selectedBatch) {
                        ForEach(batchOptions, id: \.self) { Text($0) }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 3)

                VStack(spacing: 15) {
                    Button("Add Student") {
                        fetchScheduleId(for: selectedClass, batch: selectedBatch) { fetchedScheduleId in
                            studentViewModel.addStudent(
                                name: name,
                                className: selectedClass,
                                batch: selectedBatch,
                                scheduleId: fetchedScheduleId // ✅ Pass scheduleId
                            )
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(name.isEmpty)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(name.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)

                    // ✅ View Students Button
                    Button("View Students") {
                        isViewingStudents.toggle()
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Add Student")
            .sheet(isPresented: $isViewingStudents) {
                StudentListView(studentViewModel: studentViewModel) // ✅ Open Student List
            }
        }
    }

    // ✅ Fetch `scheduleId` from Firestore based on class and batch
    private func fetchScheduleId(for className: String, batch: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        db.collection("schedules")
            .whereField("class", isEqualTo: className)
            .whereField("batch", isEqualTo: batch)
            .getDocuments { snapshot, error in
                guard let document = snapshot?.documents.first else {
                    print("⚠️ No matching schedule found for \(className) - Batch \(batch)")
                    completion(nil) // ✅ No matching schedule found
                    return
                }
                print("✅ Found scheduleId: \(document.documentID) for \(className) - Batch \(batch)")
                completion(document.documentID) // ✅ Found scheduleId
            }
    }
}
