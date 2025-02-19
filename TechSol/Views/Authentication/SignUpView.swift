import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                    .shadow(radius: 10)
                
                CustomTextField(icon: "person", placeholder: "Name", text: $name)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                
                CustomTextField(icon: "envelope", placeholder: "Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                
                CustomTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)

                CustomTextField(icon: "lock", placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)

                
                Button(action: signupUser) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Sign Up")
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
                
                NavigationLink("Already have a account? Login", destination: LoginView())
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 50)
        }
        .navigationTitle("Sign Up")
    }
    
    private func signupUser(){
        isLoading = true
        errorMessage = nil
        
        if confirmPassword == password{
            authViewModel.signUp(name: name, email: email, password: password) { success in
                if success {
                    print("User signed up successfully")
                }
            }
        }
    }
}

#Preview{
    SignUpView()
}
