import SwiftUI

struct StudentListView: View {
    @ObservedObject var studentViewModel: StudentViewModel

    var sortedStudents: [String: [StudentInfo]] {
        Dictionary(grouping: studentViewModel.students, by: { $0.className })
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(sortedStudents.keys.sorted(), id: \.self) { className in
                    Section(header: Text(className).font(.headline).bold()) {
                        ForEach(sortedStudents[className] ?? []) { student in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(student.name)
                                        .font(.headline)
                                    Text("Batch: \(student.batch)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(5)
                        }
                    }
                }
            }
            .navigationTitle("Students List")
        }
    }
}
