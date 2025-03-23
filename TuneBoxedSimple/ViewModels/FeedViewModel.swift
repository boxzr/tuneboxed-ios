import Foundation
import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    // Published properties
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadPosts()
    }
    
    func loadPosts() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // In a real app, this would fetch from an API
            self.posts = Post.samplePosts
            self.isLoading = false
        }
    }
    
    func refreshFeed() {
        // Simulate pull-to-refresh
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Shuffle posts to simulate new content
            self.posts = Post.samplePosts.shuffled()
            self.isLoading = false
        }
    }
    
    func likePost(postId: String) {
        // This would update the backend in a real app
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            var updatedPost = posts[index]
            // In a real app, this would toggle and make an API call
            let updatedPosts = posts.map { post in
                if post.id == postId {
                    // Create a new post with updated like count
                    return Post(
                        id: post.id,
                        userId: post.userId,
                        username: post.username,
                        userProfileImageUrl: post.userProfileImageUrl,
                        isVerified: post.isVerified,
                        songTitle: post.songTitle,
                        artistName: post.artistName,
                        albumCoverUrl: post.albumCoverUrl,
                        postDescription: post.postDescription,
                        timePosted: post.timePosted,
                        likes: post.likes + 1,
                        comments: post.comments,
                        audioUrl: post.audioUrl
                    )
                }
                return post
            }
            posts = updatedPosts
        }
    }
    
    // Format relative time for post
    func formatRelativeTime(date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: now)
        
        if let day = components.day, day > 0 {
            return "\(day)d ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)h ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)m ago"
        } else {
            return "Just now"
        }
    }
} 