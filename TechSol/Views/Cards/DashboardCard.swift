import SwiftUI

struct DashboardCard: View {
    var icon: String
    var title: String
    var color: Color

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Circle())

            Text(title)
                .foregroundColor(.black)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(width: 150, height: 150)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    //DashboardCard(icon: "list.bullet", title: "View Inventory", color: .green)
    //DashboardCard(icon: "calendar", title: "View Schedules", color: .orange)
    DashboardCard(icon: "exclamationmark.triangle.fill", title: "Report Issue", color: .red)
}
