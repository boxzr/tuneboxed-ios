import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    // Published properties for authentication state
    @Published var authState: AuthState = .unauthenticated
    @Published var currentUser: User?
    @Published var signUpCredentials = SignUpCredentials()
    @Published var loginCredentials = LoginCredentials()
    @Published var showLoadingScreen = false
    @Published var isShowingSignUp = false
    
    // Error handling
    @Published var errorMessage: String?
    @Published var showError = false
    
    // Mock authentication
    func signUp() {
        authState = .loading
        showLoadingScreen = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Mock successful signup
            if self.signUpCredentials.isValid() {
                let newUser = User(
                    id: UUID().uuidString,
                    username: self.signUpCredentials.username,
                    profilePictureUrl: nil,
                    email: self.signUpCredentials.email,
                    fullName: self.signUpCredentials.fullName,
                    bio: nil,
                    followers: 0,
                    following: 0,
                    posts: 0,
                    isVerified: false,
                    isPremium: false
                )
                
                self.currentUser = newUser
                self.authState = .authenticated(newUser)
                self.resetCredentials()
            } else {
                self.errorMessage = "Please fill in all required fields"
                self.showError = true
                self.authState = .error(self.errorMessage ?? "Unknown error")
                self.showLoadingScreen = false
            }
        }
    }
    
    func login() {
        authState = .loading
        showLoadingScreen = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Mock login logic - in a real app, this would validate against a backend
            if self.loginCredentials.email.lowercased() == "demo@example.com" && 
               self.loginCredentials.password == "password123" {
                let user = User.sampleUser
                self.currentUser = user
                self.authState = .authenticated(user)
                self.resetCredentials()
            } else {
                self.errorMessage = "Invalid email or password"
                self.showError = true
                self.authState = .error(self.errorMessage ?? "Unknown error")
                self.showLoadingScreen = false
            }
        }
    }
    
    func signOut() {
        self.currentUser = nil
        self.authState = .unauthenticated
        self.showLoadingScreen = false
    }
    
    private func resetCredentials() {
        signUpCredentials = SignUpCredentials()
        loginCredentials = LoginCredentials()
    }
    
    // Password validation
    func passwordMeetsRequirements() -> Bool {
        return PasswordValidation.meetsMinimumRequirements(signUpCredentials.password)
    }
    
    func isStrongPassword() -> Bool {
        return PasswordValidation.isStrongPassword(signUpCredentials.password)
    }
} 