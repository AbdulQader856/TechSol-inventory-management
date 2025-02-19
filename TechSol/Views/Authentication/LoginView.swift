import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // App Logo
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                    .shadow(radius: 10)
                
                // Email Field
                CustomTextField(icon: "envelope", placeholder: "Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                
                // Password Field
                CustomTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                
                // Login Button
                Button(action: loginUser) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
                            .shadow(radius: 5)
                    }
                }
                .disabled(isLoading)
                
                // Error Message Alert
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                // Sign Up Link
                NavigationLink("Don't have an account? Sign Up", destination: SignUpView())
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 50)
        }
        .navigationBarHidden(true)
    }

    private func loginUser() {
        isLoading = true
        errorMessage = nil

        authViewModel.login(email: email, password: password) { success in
            isLoading = false
            if !success {
                errorMessage = "Login failed. Please check your credentials."
            }
        }
    }
}

#Preview{
    LoginView()
}
