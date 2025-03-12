import SwiftUI

// MARK: - App Entry Point
@main
struct TuneBoxedSimpleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Post Model
struct Post: Identifiable {
    var id = UUID()
    var songTitle: String
    var artist: String
    var username: String
    var likes: Int
    var isLiked: Bool = false
}

// Sample posts
let samplePosts = [
    Post(songTitle: "Dreams", artist: "Fleetwood Mac", username: "boxzr", likes: 42),
    Post(songTitle: "Take On Me", artist: "a-ha", username: "musiclover", likes: 37),
    Post(songTitle: "Mr. Brightside", artist: "The Killers", username: "rockfan", likes: 53)
]

// MARK: - Launch Screen
struct LaunchScreen: View {
    @Binding var showLaunchScreen: Bool
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            // Updated to a gradient for a more futuristic look
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Simple text logo with animation
                Text("TB")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 150, height: 150)
                    )
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            rotation = 10
                        }
                    }
                
                Text("TuneBoxed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding()
            }
        }
        .onAppear {
            // Dismiss launch screen after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showLaunchScreen = false
                }
            }
        }
    }
}

// MARK: - Post View
struct PostView: View {
    @State private var post: Post
    @State private var scale: CGFloat = 1.0
    
    init(post: Post) {
        _post = State(initialValue: post)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(post.username.prefix(1)).uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                
                Text(post.username)
                    .font(.headline)
                
                if post.username == "boxzr" {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            
            // Song info with updated styling
            HStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.7), .blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "music.note")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading) {
                    Text(post.songTitle)
                        .font(.headline)
                    
                    Text(post.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.purple)
                        .scaleEffect(scale)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                scale = 1.1
                            }
                        }
                }
            }
            
            // Like button with animation
            Button(action: {
                withAnimation(.spring()) {
                    post.isLiked.toggle()
                    post.likes += post.isLiked ? 1 : -1
                }
            }) {
                HStack {
                    Image(systemName: post.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(post.isLiked ? .red : .gray)
                    
                    Text("\(post.likes) likes")
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

// MARK: - Feed View
struct FeedView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(samplePosts, id: \.id) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("Feed")
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @State private var profileImageScale: CGFloat = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile header with verified badge
                VStack {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 100, height: 100)
                            .scaleEffect(profileImageScale)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                    profileImageScale = 1.05
                                }
                            }
                            .overlay(
                                Text("B")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .bold))
                            )
                        
                        // Verified badge
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .background(Circle().fill(Color.white).frame(width: 22, height: 22))
                            .font(.system(size: 24))
                            .offset(x: 40, y: 40)
                    }
                    
                    HStack {
                        Text("boxzr")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 16))
                    }
                    
                    Text("Music enthusiast | Sharing my favorite tunes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Stats with updated styling
                    HStack(spacing: 40) {
                        VStack {
                            Text("42")
                                .font(.headline)
                                .foregroundColor(.purple)
                            Text("Posts")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("128")
                                .font(.headline)
                                .foregroundColor(.purple)
                            Text("Followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("97")
                                .font(.headline)
                                .foregroundColor(.purple)
                            Text("Following")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal, 8)
                
                // My posts header with gradient
                Text("My Posts")
                    .font(.headline)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.1), .blue.opacity(0.05)]), startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(8)
                    )
                    .padding(.horizontal)
                
                ForEach(samplePosts.prefix(2), id: \.id) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("Profile")
    }
}

// MARK: - Content View
struct ContentView: View {
    @State private var showLaunchScreen = true
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                NavigationView {
                    FeedView()
                }
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Feed")
                }
                .tag(0)
                
                NavigationView {
                    ProfileView()
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)
            }
            .accentColor(.purple)  // Set accent color for the app
            
            if showLaunchScreen {
                LaunchScreen(showLaunchScreen: $showLaunchScreen)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(showLaunchScreen: .constant(true))
    }
} 