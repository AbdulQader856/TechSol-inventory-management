import SwiftUI

struct ScheduleView: View {
    @ObservedObject var scheduleViewModel = ScheduleViewModel()
    @State private var isAddingSchedule = false
    @State private var selectedFilter = "All"
    @State private var isGridView = false

    let filterOptions = ["All", "Lab 1", "Lab 2", "MCA 1st Semester", "MCA 2nd Semester", "MCA 3rd Semester", "Batch A", "Batch B", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    var filteredSchedules: [Schedule] {
        if selectedFilter == "All" {
            return scheduleViewModel.schedules
        } else {
            return scheduleViewModel.schedules.filter { schedule in
                schedule.lab.contains(selectedFilter) ||
                schedule.className.contains(selectedFilter) ||
                schedule.batch.contains(selectedFilter) ||
                schedule.days.contains(selectedFilter)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Filter & View Toggle
                HStack {
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(filterOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 150)

                    Spacer()

                    Button(action: { isGridView.toggle() }) {
                        Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 10)
                }
                .padding()

                // Schedule List/Grid
                ScrollView {
                    if filteredSchedules.isEmpty {
                        VStack {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                            Text("No schedules available.")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 50)
                    } else {
                        if isGridView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                ForEach(filteredSchedules) { schedule in
                                    ScheduleCard(schedule: schedule)
                                }
                            }
                            .padding()
                        } else {
                            VStack(spacing: 15) {
                                ForEach(filteredSchedules) { schedule in
                                    ScheduleRow(schedule: schedule)
                                }
                            }
                            .padding()
                        }
                    }
                }

                // Add Schedule Button (Sticky at Bottom)
                Button(action: { isAddingSchedule.toggle() }) {
                    Text("Add Schedule")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .navigationTitle("Schedules")
            .sheet(isPresented: $isAddingSchedule) {
                AddScheduleView(scheduleViewModel: scheduleViewModel)
            }
        }
    }
}



#Preview {
    ScheduleView()
}
