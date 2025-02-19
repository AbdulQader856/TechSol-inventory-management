import SwiftUI

struct IssueReportView: View {
    var item: InventoryItem
    var assignedStudentName: String?
    @ObservedObject var issueViewModel = IssueViewModel()
    @State private var description = ""
    
    var body: some View {
        NavigationView {ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Report an Issue")
                    .font(.title)
                    .bold()
                    .padding(.top, 10)
                
                VStack(spacing: 15) {
                    Text("Equipment ID: \(item.id?.suffix(5) ?? "Unknown")") // ✅ Short ID
                        .font(.headline)
                    
                    if let studentName = assignedStudentName {
                        Text("Assigned to: \(studentName)") // ✅ Show assigned student
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    
                    Text("Describe the Issue").font(.headline)
                    TextField("Enter description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 3)
                
                // ✅ Submit Issue Button
                Button("Submit Report") {
                    issueViewModel.addIssue(
                        equipmentId: item.id ?? "Unknown",
                        reportedBy: "Lab Assistant", // ✅ Replace with actual user ID if needed
                        assignedStudent: item.assignedTo?.studentId ?? "Unassigned",
                        description: description
                    )
                    description = ""
                }
                .disabled(description.isEmpty)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(description.isEmpty ? Color.gray : Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Report Issue")
        }
        }
    }
}
