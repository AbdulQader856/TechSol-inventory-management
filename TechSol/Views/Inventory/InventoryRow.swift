import SwiftUI

struct InventoryRow: View {
    var item: InventoryItem
    var assignedStudentName: String?
    @State private var isReportingIssue = false // ✅ Controls issue reporting sheet

    var body: some View {
        HStack {
            Image(systemName: getSymbol(for: item.type))
                .font(.title)
                .foregroundColor(.blue)

            VStack(alignment: .leading) {
                Text("ID: \(item.id?.suffix(5) ?? "Unknown")") // ✅ Shorter ID
                    .font(.headline)

                Text(item.type.joined(separator: ", ")) // ✅ Show multiple types
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Status: \(item.status.joined(separator: ", "))") // ✅ Show multiple statuses
                    .font(.subheadline)
                    .foregroundColor(item.status.contains("available") ? .green : item.status.contains("assigned") ? .orange : .red)

                // ✅ Show assigned student
                if let studentName = assignedStudentName {
                    Text("Assigned to: \(studentName)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                }
            }

            Spacer()

            // ✅ Report Issue Button (Opens ReportIssueView)
            Button(action: { isReportingIssue.toggle() }) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            .sheet(isPresented: $isReportingIssue) {
                IssueReportView(item: item, assignedStudentName: assignedStudentName)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    // ✅ Function to get SF Symbol based on type
    private func getSymbol(for types: [String]) -> String {
        if types.contains("Computer") { return "desktopcomputer" }
        else if types.contains("Mouse") { return "computermouse.fill" }
        else if types.contains("Keyboard") { return "keyboard.fill" }
        return "questionmark.circle"
    }
}
