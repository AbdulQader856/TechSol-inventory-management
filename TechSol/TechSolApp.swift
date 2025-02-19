import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TechSolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var inventoryViewModel = InventoryViewModel() // ✅ Inject InventoryViewModel
    @StateObject var issueViewModel = IssueViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authViewModel.isAuthenticated {
                    LabAssistantDashboardView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(authViewModel)
            .environmentObject(inventoryViewModel) // ✅ Provide InventoryViewModel globally
            .environmentObject(issueViewModel)
        }
    }
}
