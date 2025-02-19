import SwiftUI

struct StudentSelectionView: View {
    @ObservedObject var studentViewModel: StudentViewModel
    @Binding var selectedStudent: StudentInfo?

    var body: some View {
        NavigationView {
            List(studentViewModel.students) { student in
                Button(action: {
                    selectedStudent = student
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(student.name)
                                .font(.headline)
                            Text("\(student.className) - Batch \(student.batch)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if selectedStudent?.id == student.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(5)
                }
            }
            .navigationTitle("Select Student")
            .onAppear {
                studentViewModel.fetchStudents()
            }
        }
    }
}
