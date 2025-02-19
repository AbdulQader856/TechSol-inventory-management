import FirebaseFirestore
import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [Schedule] = []
    private var db = Firestore.firestore()

    init() {
        fetchSchedules()
    }

    func fetchSchedules() {
        db.collection("schedules").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No schedules found")
                return
            }
            DispatchQueue.main.async {
                self.schedules = documents.compactMap { doc in
                    var schedule = try? doc.data(as: Schedule.self)
                    schedule?.id = doc.documentID // Ensure ID is assigned
                    return schedule
                }.compactMap { $0 }
            }
        }
    }

    func addSchedule(_ schedule: Schedule) {
        let scheduleRef = db.collection("schedules").document(schedule.scheduleId)

        do {
            try scheduleRef.setData([
                "scheduleId": schedule.scheduleId,
                "lab": schedule.lab,
                "className": schedule.className,
                "batch": schedule.batch,
                "days": schedule.days,
                "timeSlot": schedule.timeSlot
            ]) { error in
                if let error = error {
                    print("Error adding schedule: \(error.localizedDescription)")
                } else {
                    print("Schedule added successfully!")
                    self.fetchSchedules() // ✅ Refresh the UI after adding
                }
            }
        } catch {
            print("Failed to save schedule: \(error.localizedDescription)")
        }
    }
}
