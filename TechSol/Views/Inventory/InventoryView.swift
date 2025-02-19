import SwiftUI
import FirebaseFirestore

struct InventoryView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @ObservedObject var studentViewModel = StudentViewModel() // ✅ Fetch student data

    @State private var selectedFilter = "All"
    @State private var isGridView = false
    @State private var searchText = ""
    @State private var isAddingItem = false

    let filterOptions = ["All", "Computers", "Mice", "Keyboards", "Available", "Assigned", "Damaged"]

    var filteredInventory: [InventoryItem] {
        return inventoryViewModel.inventoryItems.filter { item in
            (selectedFilter == "All" ||
             (selectedFilter == "Computers" && item.type.contains("Computer")) ||
             (selectedFilter == "Mice" && item.type.contains("Mouse")) ||
             (selectedFilter == "Keyboards" && item.type.contains("Keyboard")) ||
             (selectedFilter == "Available" && item.status.contains("available")) ||
             (selectedFilter == "Assigned" && item.status.contains("assigned")) ||
             (selectedFilter == "Damaged" && item.status.contains("damaged"))) &&
            (searchText.isEmpty || (item.id ?? "").localizedCaseInsensitiveContains(searchText))
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search by ID...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)

                    Spacer()

                    Button(action: { isGridView.toggle() }) {
                        Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 10)
                }
                .padding()

                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                ScrollView {
                    if filteredInventory.isEmpty {
                        VStack {
                            Image(systemName: "tray.full")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                            Text("No inventory items found.")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 50)
                    } else {
                        if isGridView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                ForEach(filteredInventory) { item in
                                    InventoryCard(item: item, assignedStudentName: studentViewModel.getStudentName(for: item.assignedTo?.studentId))
                                }
                            }
                            .padding()
                        } else {
                            VStack(spacing: 15) {
                                ForEach(filteredInventory) { item in
                                    InventoryRow(item: item, assignedStudentName: studentViewModel.getStudentName(for: item.assignedTo?.studentId))
                                }
                            }
                            .padding()
                        }
                    }
                }

                Button(action: { isAddingItem.toggle() }) {
                    Text("Add Inventory Item")
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
            .navigationTitle("Inventory")
            .sheet(isPresented: $isAddingItem) {
                AddInventoryView(inventoryViewModel: inventoryViewModel)
            }
        }
    }
}
