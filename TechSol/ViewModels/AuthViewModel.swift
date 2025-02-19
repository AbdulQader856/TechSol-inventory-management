import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
                completion(false)
                return
            }
            DispatchQueue.main.async {
                self.isAuthenticated = true
            }
            completion(true)
        }
    }

    func signUp(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Signup failed: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let userId = result?.user.uid {
                let db = Firestore.firestore()
                db.collection("users").document(userId).setData([
                    "name": name,
                    "email": email,
                    "role": "lab_assistant"
                ]) { error in
                    if let error = error {
                        print("Error saving user to Firestore: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        DispatchQueue.main.async {
                            self.isAuthenticated = true
                        }
                        completion(true)
                    }
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isAuthenticated = false
            }
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}
