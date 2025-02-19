import SwiftUI

struct AddScheduleView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scheduleViewModel: ScheduleViewModel

    @State private var selectedLabs: Set<String> = []
    @State private var selectedClasses: Set<String> = []
    @State private var selectedBatches: Set<String> = []
    @State private var selectedDays: Set<String> = []
    @State private var selectedTimeSlot = "10:00 AM - 12:00 PM"

    let labs = ["Lab 1", "Lab 2"]
    let classes = ["MCA 1st Semester", "MCA 2nd Semester", "MCA 3rd Semester"]
    let batches = ["A", "B"]
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let timeSlots = ["10:00 AM - 12:00 PM", "12:30 PM - 2:30 PM", "2:30 PM - 4:30 PM"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Lab Selection
                    Text("Select Labs").font(.headline)
                    selectionList(items: labs, selectedItems: $selectedLabs)
                    
                    // Class Selection
                    Text("Select Classes").font(.headline)
                    selectionList(items: classes, selectedItems: $selectedClasses)
                    
                    // Batch Selection
                    Text("Select Batches").font(.headline)
                    selectionList(items: batches, selectedItems: $selectedBatches)
                    
                    // Days Selection
                    Text("Select Days").font(.headline)
                    selectionList(items: days, selectedItems: $selectedDays)
                    
                    // Time Slot Selection
                    Text("Select Time Slot").font(.headline)
                    Picker("Time Slot", selection: $selectedTimeSlot) {
                        ForEach(timeSlots, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Save Button
                    Button("Save Schedule") {
                        saveSchedule()
                    }
                    .disabled(selectedLabs.isEmpty || selectedClasses.isEmpty || selectedBatches.isEmpty || selectedDays.isEmpty)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background((selectedLabs.isEmpty || selectedClasses.isEmpty || selectedBatches.isEmpty || selectedDays.isEmpty) ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding()
            }
            .navigationTitle("Add Schedule")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    // Helper function for checkmark selection list
    private func selectionList(items: [String], selectedItems: Binding<Set<String>>) -> some View {
        VStack {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    if selectedItems.wrappedValue.contains(item) {
                        selectedItems.wrappedValue.remove(item)
                    } else {
                        selectedItems.wrappedValue.insert(item)
                    }
                }) {
                    HStack {
                        Text(item)
                        Spacer()
                        if selectedItems.wrappedValue.contains(item) {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
                        } else {
                            Image(systemName: "circle").foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
        }
    }

    // Function to save schedule
    private func saveSchedule() {
        let newSchedule = Schedule(
            scheduleId: UUID().uuidString,
            lab: Array(selectedLabs),
            className: Array(selectedClasses),
            batch: Array(selectedBatches),
            days: Array(selectedDays),
            timeSlot: selectedTimeSlot
        )

        scheduleViewModel.addSchedule(newSchedule)
        presentationMode.wrappedValue.dismiss() // ✅ Dismiss after saving
    }
}
