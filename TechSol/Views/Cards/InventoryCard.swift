import SwiftUI

struct InventoryCard: View {
    var item: InventoryItem
    var assignedStudentName: String? // ✅ Pass student's name if assigned

    var body: some View {
        VStack {
            Image(systemName: item.type.contains("Computer") ? "desktopcomputer" : item.type.contains("Mouse") ? "computermouse" : "keyboard")
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .padding()

            // ✅ Show a shorter version of the ID (last 5 characters)
            Text("ID: \(item.id?.suffix(5) ?? "Unknown")")
                .font(.headline)

            Text(item.type.joined(separator: ", ")) // ✅ Show multiple types
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Status: \(item.status.joined(separator: ", "))") // ✅ Show multiple statuses
                .font(.subheadline)
                .foregroundColor(item.status.contains("available") ? .green : item.status.contains("assigned") ? .orange : .red)

            // ✅ Show assigned student's name if assigned
            if let studentName = assignedStudentName {
                Text("Assigned to: \(studentName)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
