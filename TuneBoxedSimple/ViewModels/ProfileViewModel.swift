import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    // Published properties
    @Published var user: User
    @Published var userPosts: [Post] = []
    @Published var isLoading = false
    @Published var isEditingProfile = false
    @Published var updatedBio: String = ""
    
    init(user: User) {
        self.user = user
        self.updatedBio = user.bio ?? ""
        loadUserPosts()
    }
    
    func loadUserPosts() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // In a real app, this would fetch user-specific posts from an API
            // For now, just filter sample posts by the user ID
            self.userPosts = Post.samplePosts.filter { $0.userId == self.user.id }
            self.isLoading = false
        }
    }
    
    func updateProfile() {
        isLoading = true
        
        // Simulate network delay for profile update
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Update the user's bio
            var updatedUser = self.user
            updatedUser.bio = self.updatedBio
            
            self.user = updatedUser
            self.isLoading = false
            self.isEditingProfile = false
        }
    }
    
    // Method to toggle premium status (for demo purposes)
    func togglePremiumStatus() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            var updatedUser = self.user
            updatedUser.isPremium.toggle()
            
            self.user = updatedUser
            self.isLoading = false
        }
    }
    
    // Format user stats for display
    func formatUserStats(count: Int) -> String {
        if count >= 1_000_000 {
            let millions = Double(count) / 1_000_000.0
            return String(format: "%.1fM", millions)
        } else if count >= 1_000 {
            let thousands = Double(count) / 1_000.0
            return String(format: "%.1fK", thousands)
        }
        return "\(count)"
    }
} 