import SwiftUI

struct ScheduleCard: View {
    var schedule: Schedule

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Lab: \(schedule.lab.joined(separator: ", "))")
                .font(.headline)
                .foregroundColor(.blue)

            Text("Classes: \(schedule.className.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Batches: \(schedule.batch.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Days: \(schedule.days.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Time: \(schedule.timeSlot)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
    }
}
