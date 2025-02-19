import SwiftUI

struct IssueListView: View {
    @ObservedObject var issueViewModel = IssueViewModel()
    
    var body: some View {
        NavigationView {
                VStack {
                    if issueViewModel.issues.isEmpty {
                        VStack {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                            Text("No issues reported.")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 50)
                    } else {
                        List(issueViewModel.issues) { issue in
                            VStack(alignment: .leading) {
                                Text("Equipment: \(issue.equipmentId.suffix(5))") // ✅ Show short ID
                                    .font(.headline)
                                Text("Assigned to: \(issue.assignedStudent.suffix(5))")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                Text("Status: \(issue.status)")
                                    .font(.subheadline)
                                    .foregroundColor(issue.status == "open" ? .red : .green)
                                Text("Description: \(issue.description)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                // ✅ Solved Button
                                Button(action: {
                                    issueViewModel.markIssueAsSolved(issueId: issue.reportId) // ✅ Mark as solved
                                }) {
                                    Text("Mark as Solved")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                                .padding(.top, 5)
                            }
                            .padding(5)
                        }
                    }
                }
                .navigationTitle("Reported Issues")
                .onAppear {
                    issueViewModel.fetchIssues() // ✅ Ensure issues are loaded
                }
            }
        }
    }

#Preview {
    IssueListView()
}
