import Foundation
import Combine

// MARK: - API Endpoints
enum APIEndpoint {
    case login
    case signup
    case posts
    case userProfile(userId: String)
    
    var path: String {
        switch self {
            case .login:
                return "/auth/login"
            case .signup:
                return "/auth/signup"
            case .posts:
                return "/posts"
            case .userProfile(let userId):
                return "/users/\(userId)"
        }
    }
}

// MARK: - Network Service
class NetworkService {
    // Singleton instance
    static let shared = NetworkService()
    
    // Base URL would be replaced with real API in production
    private let baseURL = "https://api.tuneboxed.com/v1"
    
    // Session for network requests
    private let session = URLSession.shared
    
    // URLRequest builder
    private func buildRequest(endpoint: APIEndpoint, method: String = "GET", body: [String: Any]? = nil) -> URLRequest? {
        guard let url = URL(string: baseURL + endpoint.path) else {
            print("Error: Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add auth token if available
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add body for POST/PUT requests
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Error serializing body: \(error)")
                return nil
            }
        }
        
        return request
    }
    
    // MARK: - Mock Endpoints for Future Implementation
    
    // Login user (mock implementation)
    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        // This would be a real API call in production
        // For now return a sample user after a delay
        return Future<User, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // Mock success
                promise(.success(User.sampleUser))
                
                // In production, we would parse the token from response
                UserDefaults.standard.set("sample_token", forKey: "authToken")
            }
        }
        .eraseToAnyPublisher()
    }
    
    // Sign up user (mock implementation)
    func signUp(email: String, fullName: String, username: String, password: String) -> AnyPublisher<User, Error> {
        // Mock implementation with delay
        return Future<User, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // Create a new user based on provided details
                let newUser = User(
                    id: UUID().uuidString,
                    username: username,
                    profilePictureUrl: nil,
                    email: email,
                    fullName: fullName,
                    bio: nil,
                    followers: 0,
                    following: 0,
                    posts: 0,
                    isVerified: false,
                    isPremium: false
                )
                
                promise(.success(newUser))
                
                // In production, we would parse the token from response
                UserDefaults.standard.set("sample_token", forKey: "authToken")
            }
        }
        .eraseToAnyPublisher()
    }
    
    // Get posts (mock implementation)
    func getPosts() -> AnyPublisher<[Post], Error> {
        return Future<[Post], Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                promise(.success(Post.samplePosts))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // Get user profile (mock implementation)
    func getUserProfile(userId: String) -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                promise(.success(User.sampleUser))
            }
        }
        .eraseToAnyPublisher()
    }
}