import SwiftUI

struct AddInventoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @ObservedObject var studentViewModel = StudentViewModel()

    @State private var selectedTypes: Set<String> = []
    @State private var brand = ""
    @State private var selectedStatuses: Set<String> = []
    @State private var isAssigned = false
    @State private var selectedStudent: StudentInfo? // ✅ Student selection
    @State private var isViewingStudents = false // ✅ Toggle for Student List

    let itemTypes = ["Computer", "Mouse", "Keyboard"]
    let statuses = ["available", "assigned", "damaged"]

    var body: some View {
        NavigationView {
            ScrollView { // ✅ Scrollable view
                VStack(spacing: 20) {
                    Text("Add Inventory Item")
                        .font(.title)
                        .bold()
                        .padding(.top, 10)

                    VStack(spacing: 15) {
                        Text("Select Equipment Type").font(.headline)
                        selectionList(items: itemTypes, selectedItems: $selectedTypes)

                        Text("Enter Brand").font(.headline)
                        TextField("Brand", text: $brand)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        Text("Select Equipment Status").font(.headline)
                        selectionList(items: statuses, selectedItems: $selectedStatuses)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(radius: 3)

                    VStack(spacing: 15) {
                        Toggle("Assign to a Student?", isOn: $isAssigned)
                            .padding(.horizontal)

                        if isAssigned {
                            VStack {
                                Text("Select Assigned Student").font(.headline)
                                Button(action: { isViewingStudents.toggle() }) {
                                    HStack {
                                        Text(selectedStudent?.name ?? "Tap to select student")
                                            .foregroundColor(selectedStudent == nil ? .gray : .black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                }
                            }
                            .padding()
                        }
                    }

                    // ✅ Add Inventory Item Button (Sticky)
                    Button("Add Inventory Item") {
                        saveInventoryItem()
                    }
                    .disabled(selectedTypes.isEmpty || selectedStatuses.isEmpty || brand.isEmpty)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background((selectedTypes.isEmpty || selectedStatuses.isEmpty || brand.isEmpty) ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.bottom, 20) // ✅ Added bottom padding for better spacing
                }
                .padding(.top, 10) // ✅ Added top padding to avoid title overlap
            }
            .navigationTitle("Add Inventory") // ✅ Fixes title overlap
            .navigationBarTitleDisplayMode(.inline) // ✅ Keeps title in a clean format
            .sheet(isPresented: $isViewingStudents) {
                StudentSelectionView(studentViewModel: studentViewModel, selectedStudent: $selectedStudent) // ✅ Navigate to Student Selection
            }
        }
    }

    // ✅ Helper function for checkmark selection list
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

    // ✅ Function to save inventory item
    private func saveInventoryItem() {
        let newInventoryItem = InventoryItem(
            id: UUID().uuidString,
            type: Array(selectedTypes),
            brand: brand,
            status: Array(selectedStatuses),
            assignedTo: isAssigned && selectedStudent != nil ? InventoryItem.AssignedStudent(
                studentId: selectedStudent?.id ?? "",
                scheduleId: selectedStudent?.scheduleId ?? ""
            ) : nil
        )

        inventoryViewModel.addInventoryItem(item: newInventoryItem)
        presentationMode.wrappedValue.dismiss() // ✅ Dismiss after saving
    }
}
