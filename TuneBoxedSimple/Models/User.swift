import Foundation
import SwiftUI

// MARK: - User Model
struct User: Identifiable, Codable {
    let id: String
    let username: String
    let profilePictureUrl: String?
    let email: String
    let fullName: String
    var bio: String?
    var followers: Int
    var following: Int
    var posts: Int
    var isVerified: Bool
    var isPremium: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case profilePictureUrl = "profile_picture_url"
        case email
        case fullName = "full_name"
        case bio
        case followers
        case following
        case posts
        case isVerified = "is_verified"
        case isPremium = "is_premium"
    }
    
    // Sample data
    static let sampleUser = User(
        id: "user1",
        username: "johndoe",
        profilePictureUrl: nil,
        email: "john@example.com",
        fullName: "John Doe",
        bio: "Music enthusiast and producer",
        followers: 1250,
        following: 350,
        posts: 42,
        isVerified: true,
        isPremium: true
    )
} 