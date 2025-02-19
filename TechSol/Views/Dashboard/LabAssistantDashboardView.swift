import SwiftUI

struct LabAssistantDashboardView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Button("Logout") {
                            authViewModel.logout()
                        }
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .frame(maxHeight: 40)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                    .padding(.trailing)
                    
                    Text("Inventory Dashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            NavigationLink(destination: InventoryView()) { // ✅ No parameter needed
                                DashboardCard(icon: "list.bullet", title: "View Inventory", color: .green)
                            }
                            
                            NavigationLink(destination: ScheduleView()) {
                                DashboardCard(icon: "calendar", title: "View Schedules", color: .orange)
                            }
                            
                            // ✅ Fix: Ensure an item is passed when opening ReportIssueView
                            //if let firstItem = inventoryViewModel.inventoryItems.first {
                            //    NavigationLink(destination: ReportIssueView(item: firstItem, assignedStudentName: nil)) {
                            //        DashboardCard(icon: "exclamationmark.triangle.fill", title: "Report an Issue", color: .mint)
                            //    }
                            //} else {
                            //    Text("No inventory items available to report issues.")
                            //        .foregroundColor(.gray)
                            //        .padding()
                            //}
                            
                            NavigationLink(destination: IssueListView()) {
                                DashboardCard(icon: "doc.text.magnifyingglass", title: "View Reports", color: .mint)
                            }
                            
                            NavigationLink(destination: AddStudentView()) {
                                DashboardCard(icon: "person.fill", title: "View Students", color: .purple)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
    }
}
#Preview {
    LabAssistantDashboardView()
}
