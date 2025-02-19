import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    //@AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack {
            //Toggle("Dark Mode", isOn: $isDarkMode)
                //.padding()

            Button("Logout") {
                authViewModel.logout()
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 5)

            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
        //.preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
