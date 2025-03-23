import Foundation
import SwiftUI

// MARK: - Post Models
struct Post: Identifiable {
    let id: String
    let userId: String
    let username: String
    let userProfileImageUrl: String?
    let isVerified: Bool
    let songTitle: String
    let artistName: String
    let albumCoverUrl: String
    let postDescription: String
    let timePosted: Date
    let likes: Int
    let comments: Int
    let audioUrl: String
    
    // Sample post data
    static let samplePosts = [
        Post(
            id: "post1",
            userId: "user1",
            username: "johndoe",
            userProfileImageUrl: nil,
            isVerified: true,
            songTitle: "Blinding Lights",
            artistName: "The Weeknd",
            albumCoverUrl: "https://example.com/album1.jpg",
            postDescription: "This song has been on repeat all week! 🔥 #TheWeeknd #BlindingLights",
            timePosted: Date().addingTimeInterval(-86400), // 1 day ago
            likes: 1542,
            comments: 87,
            audioUrl: "https://example.com/audio1.mp3"
        ),
        Post(
            id: "post2",
            userId: "user2",
            username: "musiclover",
            userProfileImageUrl: nil,
            isVerified: false,
            songTitle: "Levitating",
            artistName: "Dua Lipa",
            albumCoverUrl: "https://example.com/album2.jpg",
            postDescription: "Perfect song for summer vibes! 🌞 #DuaLipa",
            timePosted: Date().addingTimeInterval(-43200), // 12 hours ago
            likes: 982,
            comments: 45,
            audioUrl: "https://example.com/audio2.mp3"
        ),
        Post(
            id: "post3",
            userId: "user3",
            username: "beatmaker",
            userProfileImageUrl: nil,
            isVerified: true,
            songTitle: "Circles",
            artistName: "Post Malone",
            albumCoverUrl: "https://example.com/album3.jpg",
            postDescription: "This melody is everything! Anyone else love this track? #PostMalone",
            timePosted: Date().addingTimeInterval(-7200), // 2 hours ago
            likes: 347,
            comments: 23,
            audioUrl: "https://example.com/audio3.mp3"
        )
    ]
}

// Comment model
struct Comment: Identifiable {
    let id: String
    let postId: String
    let userId: String
    let username: String
    let userProfileImageUrl: String?
    let isVerified: Bool
    let text: String
    let timePosted: Date
    let likes: Int
} 