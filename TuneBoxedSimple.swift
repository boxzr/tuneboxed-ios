import SwiftUI

// MARK: - Custom Colors
extension Color {
    // Logo-based colors (adjust these RGB values to match your logo)
    static let logoMain = Color(red: 0.5, green: 0.2, blue: 0.8) // Purple-ish
    static let logoAccent = Color(red: 0.2, green: 0.4, blue: 0.9) // Blue-ish
    
    static let primaryPurple = Color.logoMain
    static let tuneBoxedGradient = LinearGradient(
        gradient: Gradient(colors: [Color.logoMain, Color.logoAccent]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

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
    var type: PostType = .regular
    var genre: String? = nil
}

enum PostType {
    case regular
    case songOfDay
    case songOfWeek
    case showerBeer
}

// Sample posts
let samplePosts = [
    Post(songTitle: "Dreams", artist: "Fleetwood Mac", username: "boxzr", likes: 42, type: .songOfWeek, genre: "70's Rock"),
    Post(songTitle: "Take On Me", artist: "a-ha", username: "musiclover", likes: 37, type: .regular),
    Post(songTitle: "Mr. Brightside", artist: "The Killers", username: "rockfan", likes: 53, type: .showerBeer)
]

// Sample shower beer playlist
let showerBeerPlaylist = [
    Post(songTitle: "Blinding Lights", artist: "The Weeknd", username: "boxzr", likes: 15, type: .showerBeer),
    Post(songTitle: "Levitating", artist: "Dua Lipa", username: "boxzr", likes: 12, type: .showerBeer),
    Post(songTitle: "Heat Waves", artist: "Glass Animals", username: "boxzr", likes: 8, type: .showerBeer)
]

// Sample communities
let communities = [
    "Indie Rock Enthusiasts",
    "80's Synth Wave",
    "Hip Hop Heads"
]

// MARK: - Launch Screen
struct LaunchScreen: View {
    @Binding var showLaunchScreen: Bool
    @State private var scale: CGFloat = 0.8
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.tuneBoxedGradient
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Logo in a circle
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 160, height: 160)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                }
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        scale = 0.9
                        rotation = 5
                    }
                }
                
                Text("TuneBoxed")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("Share Your Sound")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, -10)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(.top, 20)
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
    
    init(post: Post) {
        _post = State(initialValue: post)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack {
                Circle()
                    .fill(Color.tuneBoxedGradient)
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
                
                // Post type badge
                if post.type != .regular {
                    Text(postTypeText)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(postTypeColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            // Genre if available
            if let genre = post.genre {
                Text(genre)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, -5)
            }
            
            // Song info
            HStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.tuneBoxedGradient)
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
                        .foregroundColor(.primaryPurple)
                }
            }
            
            // Like button
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
    
    // Helper properties for post type
    private var postTypeText: String {
        switch post.type {
        case .songOfDay: return "Song of Day"
        case .songOfWeek: return "Song of Week"
        case .showerBeer: return "Shower Beer"
        default: return ""
        }
    }
    
    private var postTypeColor: Color {
        switch post.type {
        case .songOfDay: return .orange
        case .songOfWeek: return .blue
        case .showerBeer: return .green
        default: return .clear
        }
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

// MARK: - Shower Beer View
struct ShowerBeerView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Your Shower Beer Playlist")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(showerBeerPlaylist, id: \.id) { post in
                    PostView(post: post)
                }
                
                Divider()
                    .padding(.vertical)
                
                Text("Friends' Shower Beer Picks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(samplePosts.filter { $0.type == .showerBeer }, id: \.id) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("Shower Beer")
    }
}

// MARK: - Communities View
struct CommunitiesView: View {
    var body: some View {
        List {
            Section(header: Text("Your Communities")) {
                ForEach(communities, id: \.self) { community in
                    HStack {
                        Circle()
                            .fill(Color.tuneBoxedGradient)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(String(community.prefix(1)).uppercased())
                                    .foregroundColor(.white)
                                    .font(.headline)
                            )
                        
                        Text(community)
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Section(header: Text("Suggested Communities")) {
                HStack {
                    Circle()
                        .fill(Color.tuneBoxedGradient)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("J")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                    
                    Text("Jazz Fusion Collective")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Join")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.tuneBoxedGradient)
                            .cornerRadius(12)
                    }
                }
                
                HStack {
                    Circle()
                        .fill(Color.tuneBoxedGradient)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("E")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                    
                    Text("EDM Enthusiasts")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Join")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.tuneBoxedGradient)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .navigationTitle("Communities")
    }
}

// MARK: - Song of Day View
struct SongOfDayView: View {
    // Sample song of the day posts
    let songOfDayPosts = [
        Post(songTitle: "Bohemian Rhapsody", artist: "Queen", username: "rockclassics", likes: 1243, type: .songOfDay, genre: "70's Rock"),
        Post(songTitle: "Billie Jean", artist: "Michael Jackson", username: "popking", likes: 982, type: .songOfDay, genre: "80's Pop"),
        Post(songTitle: "Smells Like Teen Spirit", artist: "Nirvana", username: "grungelover", likes: 876, type: .songOfDay, genre: "90's Grunge")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Today's featured song
                VStack(alignment: .leading) {
                    Text("Today's Featured")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottomLeading) {
                        // Background image (using a gradient as placeholder)
                        Rectangle()
                            .fill(Color.tuneBoxedGradient)
                            .frame(height: 200)
                            .cornerRadius(15)
                        
                        // Song info overlay
                        VStack(alignment: .leading, spacing: 4) {
                            Text("SONG OF THE DAY")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text(songOfDayPosts[0].songTitle)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(songOfDayPosts[0].artist)
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text(songOfDayPosts[0].genre ?? "")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.top, 2)
                            
                            HStack {
                                Button(action: {}) {
                                    Label("Play", systemImage: "play.fill")
                                        .font(.caption)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.white)
                                        .foregroundColor(.logoMain)
                                        .cornerRadius(20)
                                }
                                
                                Button(action: {}) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                        .font(.caption)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.white.opacity(0.3))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.top, 8)
                        }
                        .padding(16)
                    }
                    .padding(.horizontal)
                }
                
                // Previous songs of the day
                Text("Previous Picks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                
                ForEach(songOfDayPosts.dropFirst(), id: \.id) { post in
                    PostView(post: post)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Song of Day")
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @State private var selectedSegment = 0
    let segments = ["Posts", "Playlists", "Communities"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Cover photo
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.tuneBoxedGradient)
                        .frame(height: 150)
                    
                    // Profile header
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 110, height: 110)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            Circle()
                                .fill(Color.tuneBoxedGradient)
                                .frame(width: 100, height: 100)
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
                        .offset(y: -50)
                        .padding(.bottom, -50)
                        
                        HStack {
                            Text("boxzr")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 16))
                        }
                        
                        Text("Just a guy with great taste in music and terrible dance moves 🎵 | Shower beer enthusiast")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        
                        // Stats
                        HStack(spacing: 40) {
                            VStack {
                                Text("0")
                                    .font(.headline)
                                    .foregroundColor(.primaryPurple)
                                Text("Posts")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            VStack {
                                Text("0")
                                    .font(.headline)
                                    .foregroundColor(.primaryPurple)
                                Text("Followers")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            VStack {
                                Text("0")
                                    .font(.headline)
                                    .foregroundColor(.primaryPurple)
                                Text("Following")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                        
                        // Edit Profile Button
                        Button(action: {}) {
                            Text("Edit Profile")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray5))
                                .cornerRadius(20)
                        }
                        .padding(.bottom, 8)
                    }
                    .padding(.horizontal)
                    .background(Color(.systemBackground))
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                    .offset(y: 50)
                }
                .padding(.bottom, 50)
                
                // Segmented control
                HStack {
                    ForEach(0..<segments.count, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedSegment = index
                            }
                        }) {
                            VStack(spacing: 8) {
                                Text(segments[index])
                                    .font(.system(size: 16, weight: selectedSegment == index ? .semibold : .regular))
                                    .foregroundColor(selectedSegment == index ? .primary : .gray)
                                
                                Rectangle()
                                    .fill(selectedSegment == index ? Color.primaryPurple : Color.clear)
                                    .frame(height: 2)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 16)
                
                // Content based on selected segment
                if selectedSegment == 0 {
                    // Posts
                    VStack(alignment: .leading) {
                        ForEach(samplePosts.filter { $0.username == "boxzr" }, id: \.id) { post in
                            PostView(post: post)
                        }
                    }
                    .padding(.top, 16)
                } else if selectedSegment == 1 {
                    // Playlists
                    VStack(alignment: .leading, spacing: 16) {
                        Text("My Playlists")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 8)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(["Shower Beer Favorites", "Workout Mix", "Chill Vibes", "Road Trip"], id: \.self) { playlist in
                                    VStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.tuneBoxedGradient)
                                            .frame(width: 160, height: 160)
                                            .overlay(
                                                VStack {
                                                    Spacer()
                                                    Text(playlist)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                        .multilineTextAlignment(.center)
                                                        .padding()
                                                }
                                            )
                                        
                                        Text("\(Int.random(in: 5...20)) songs")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 4)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    // Communities
                    VStack(alignment: .leading) {
                        Text("My Communities")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 8)
                        
                        ForEach(communities, id: \.self) { community in
                            HStack {
                                Circle()
                                    .fill(Color.tuneBoxedGradient)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(String(community.prefix(1)).uppercased())
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(community)
                                        .font(.headline)
                                    
                                    Text("\(Int.random(in: 100...5000)) members")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarItems(trailing:
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.primary)
            }
        )
    }
}

// Helper for rounded corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
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
                    SongOfDayView()
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily")
                }
                .tag(1)
                
                NavigationView {
                    ShowerBeerView()
                }
                .tabItem {
                    Image(systemName: "drop.fill")
                    Text("Shower Beer")
                }
                .tag(2)
                
                NavigationView {
                    CommunitiesView()
                }
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Communities")
                }
                .tag(3)
                
                NavigationView {
                    ProfileView()
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
            }
            .accentColor(.primaryPurple)
            
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