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
    @State private var isLoading = true
    @State private var loadingText = "Loading"
    @State private var counter = 0
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.8), Color(red: 0.5, green: 0.1, blue: 0.8)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            // Background gradient
            gradient
                .ignoresSafeArea()
            
            // Animated circles in background
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 200, height: 200)
                .position(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * 0.2)
                .blur(radius: 20)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 300, height: 300)
                .position(x: UIScreen.main.bounds.width * 0.8, y: UIScreen.main.bounds.height * 0.7)
                .blur(radius: 30)
            
            VStack(spacing: 24) {
                Spacer()
                
                // Logo
                ZStack {
                    // Check if Logo image exists, otherwise use text logo
                    if UIImage(named: "Logo") != nil {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 180, height: 180)
                            )
                    } else {
                        // Fallback to text logo
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 180, height: 180)
                            
                            Text("TB")
                                .font(.system(size: 70, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        scale = 1.1
                    }
                    withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
                
                VStack(spacing: 8) {
                    Text("TuneBoxed")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Share Your Sound")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                        opacity = 1.0
                    }
                }
                
                Spacer()
                
                if isLoading {
                    VStack {
                        // Animated loading indicator
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 4)
                                .opacity(0.3)
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                            
                            Circle()
                                .trim(from: 0, to: 0.7)
                                .stroke(lineWidth: 4)
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .rotationEffect(Angle(degrees: rotation))
                        }
                        .padding(.bottom, 8)
                        
                        Text(loadingText)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .onReceive(timer) { _ in
            if isLoading {
                // Update loading text with animated dots
                counter += 1
                
                switch counter % 4 {
                case 0:
                    loadingText = "Loading"
                case 1:
                    loadingText = "Loading."
                case 2:
                    loadingText = "Loading.."
                case 3:
                    loadingText = "Loading..."
                default:
                    loadingText = "Loading"
                }
                
                // After 3 seconds, complete loading
                if counter >= 6 {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isLoading = false
                    }
                    
                    // After a short delay, dismiss the launch screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            showLaunchScreen = false
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Post View
struct PostView: View {
    @State private var post: Post
    
    init(post: Post) {
        _post = State(initialValue: post)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(post.username.prefix(1)).uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                
                Text(post.username)
                    .font(.headline)
                
                Spacer()
            }
            
            // Song info
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "music.note")
                            .font(.system(size: 30))
                            .foregroundColor(.purple)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
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
                }
            }
            
            // Like button
            Button(action: {
                post.isLiked.toggle()
                post.likes += post.isLiked ? 1 : -1
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
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile header
                VStack {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text("B")
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .bold))
                        )
                    
                    Text("boxzr")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Music enthusiast | Sharing my favorite tunes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack(spacing: 40) {
                        VStack {
                            Text("42")
                                .font(.headline)
                            Text("Posts")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("128")
                                .font(.headline)
                            Text("Followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("97")
                                .font(.headline)
                            Text("Following")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                .padding()
                
                // My posts
                Text("My Posts")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
