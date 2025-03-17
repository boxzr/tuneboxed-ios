import SwiftUI

// MARK: - Custom Colors
extension Color {
    // Logo-based colors (adjust these RGB values to match your logo)
    static let logoMain = Color(red: 0.5, green: 0.2, blue: 0.8) // Purple-ish
    static let logoAccent = Color(red: 0.2, green: 0.4, blue: 0.9) // Blue-ish
    static let neonBlue = Color(red: 0.0, green: 0.8, blue: 1.0)
    static let neonPink = Color(red: 1.0, green: 0.2, blue: 0.8)
    
    static let primaryPurple = Color.logoMain
    static let tuneBoxedGradient = LinearGradient(
        gradient: Gradient(colors: [Color.logoMain, Color.logoAccent]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let futuristicGradient = LinearGradient(
        gradient: Gradient(colors: [Color.neonBlue.opacity(0.8), Color.neonPink.opacity(0.8)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// Custom font extension for Instagram-like look
extension Font {
    static func instagramFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .rounded)
    }
    
    static let instagramTitle = instagramFont(size: 24, weight: .semibold)
    static let instagramHeadline = instagramFont(size: 16, weight: .semibold)
    static let instagramSubheadline = instagramFont(size: 14, weight: .medium)
    static let instagramBody = instagramFont(size: 14, weight: .regular)
    static let instagramCaption = instagramFont(size: 12, weight: .regular)
    
    // Also define the futuristic fonts that were referenced but not defined
    static func futuristicFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .rounded)
    }
    
    static let futuristicTitle = futuristicFont(size: 24, weight: .bold)
    static let futuristicHeadline = futuristicFont(size: 18, weight: .semibold)
    static let futuristicSubheadline = futuristicFont(size: 16, weight: .medium)
    static let futuristicBody = futuristicFont(size: 14, weight: .regular)
    static let futuristicCaption = futuristicFont(size: 12, weight: .regular)
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
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var pulseOpacity: Double = 0.6
    @State private var bufferProgress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            // Background animated elements
            ZStack {
                // Animated circles
                ForEach(0..<5) { i in
                    Circle()
                        .stroke(lineWidth: 2)
                        .fill(Color.tuneBoxedGradient)
                        .frame(width: 100 + CGFloat(i * 50), height: 100 + CGFloat(i * 50))
                        .opacity(0.1 + (0.05 * Double(i)))
                        .scaleEffect(pulseOpacity + (0.05 * Double(i)))
                }
                
                // Glowing background
                Circle()
                    .fill(Color.logoMain.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .blur(radius: 20)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    pulseOpacity = 1.0
                }
            }
            
            VStack(spacing: 30) {
                // Logo in a circle
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 160, height: 160)
                        .shadow(color: Color.logoMain.opacity(0.5), radius: 15, x: 0, y: 0)
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                }
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        scale = 0.95
                        rotation = 5
                    }
                }
                
                Text("TuneBoxed")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: Color.logoMain.opacity(0.8), radius: 10, x: 0, y: 0)
                
                Text("Share Your Sound")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, -15)
                
                // Custom buffering animation
                VStack(spacing: 15) {
                    // Circular progress bar
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 4)
                            .opacity(0.3)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                        
                        Circle()
                            .trim(from: 0.0, to: bufferProgress)
                            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.logoAccent)
                            .rotationEffect(Angle(degrees: 270.0))
                            .frame(width: 50, height: 50)
                            .animation(Animation.linear(duration: 0.1))
                        
                        // Pulsing dot in the center
                        Circle()
                            .fill(Color.logoMain)
                            .frame(width: 10, height: 10)
                            .scaleEffect(pulseOpacity)
                    }
                    
                    Text("Loading...")
                        .font(.instagramCaption)
                        .foregroundColor(.white.opacity(0.7))
                }
                .onAppear {
                    // Animate the buffer progress
                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        bufferProgress += 0.01
                        if bufferProgress >= 1.0 {
                            bufferProgress = 0.0
                        }
                    }
                }
            }
        }
        .onAppear {
            // Dismiss launch screen after 4 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation(.easeOut(duration: 0.8)) {
                    showLaunchScreen = false
                }
            }
        }
    }
}

// MARK: - Post View
struct PostView: View {
    @State private var post: Post
    @State private var showAnimation: Bool = false
    
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
                            .font(.instagramHeadline)
                    )
                
                Text(post.username)
                    .font(.instagramHeadline)
                
                if post.username == "boxzr" {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
                
                Spacer()
                
                // Post type badge
                if post.type != .regular {
                    Text(postTypeText)
                        .font(.instagramCaption)
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
                    .font(.instagramSubheadline)
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
                    .shadow(color: Color.logoMain.opacity(0.5), radius: 5, x: 0, y: 0)
                
                VStack(alignment: .leading) {
                    Text(post.songTitle)
                        .font(.instagramHeadline)
                    
                    Text(post.artist)
                        .font(.instagramSubheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        showAnimation.toggle()
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.logoMain)
                        .shadow(color: showAnimation ? Color.logoMain.opacity(0.8) : .clear, radius: 10, x: 0, y: 0)
                        .scaleEffect(showAnimation ? 1.1 : 1.0)
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
                        .scaleEffect(post.isLiked ? 1.2 : 1.0)
                        .animation(.spring(), value: post.isLiked)
                    
                    Text("\(post.likes) likes")
                        .font(.instagramBody)
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
        .onAppear {
            withAnimation(.easeIn(duration: 0.3).delay(0.1)) {
                // Trigger any animations when view appears
            }
        }
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
    // Premium feature
    @State private var isPremium = false
    
    // Sample shower beer playlist
    let showerBeerSongs = [
        (title: "Blinding Lights", artist: "The Weeknd", duration: "3:20"),
        (title: "Levitating", artist: "Dua Lipa", duration: "3:23"),
        (title: "Heat Waves", artist: "Glass Animals", duration: "3:58"),
        (title: "Watermelon Sugar", artist: "Harry Styles", duration: "2:54"),
        (title: "Don't Start Now", artist: "Dua Lipa", duration: "3:03")
    ]
    
    var body: some View {
        ScrollView {
            // Preview of the playlist that's more visible
            VStack(alignment: .leading, spacing: 0) {
                // Playlist preview content that shows behind the lock
                VStack(alignment: .leading, spacing: 0) {
                    // Playlist header with large art
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack(alignment: .bottom) {
                            // Cover art background
                            Rectangle()
                                .fill(Color.tuneBoxedGradient)
                                .frame(height: 320)
                            
                            // Playlist info overlay
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Shower Beer")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("The ultimate shower playlist")
                                    .font(.instagramSubheadline)
                                    .foregroundColor(.white.opacity(0.9))
                                
                                HStack {
                                    Text("5 songs")
                                    Text("•")
                                    Text("16 min")
                                }
                                .font(.instagramCaption)
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.top, 5)
                            }
                            .padding(24)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                        }
                    }
                    
                    // Song previews in a cleaner list
                    VStack(spacing: 0) {
                        ForEach(0..<min(4, showerBeerSongs.count), id: \.self) { index in
                            HStack(spacing: 16) {
                                Text("\(index + 1)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.gray)
                                    .frame(width: 25)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(showerBeerSongs[index].title)
                                        .font(.instagramHeadline)
                                    
                                    Text(showerBeerSongs[index].artist)
                                        .font(.instagramSubheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(showerBeerSongs[index].duration)
                                    .font(.instagramCaption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            
                            if index < 3 {
                                Divider()
                                    .padding(.leading, 60)
                            }
                        }
                    }
                    .background(Color(.systemBackground))
                }
                
                // Premium lock overlay with Instagram-style colors
                ZStack {
                    Color.black.opacity(0.9)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 25) {
                        // Lock icon
                        Image(systemName: "lock.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                        
                        Text("Premium Feature")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Upgrade to TuneBoxed Premium to access Shower Beer playlists")
                            .font(.instagramBody)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 40)
                        
                        Button(action: {
                            // For demo purposes, unlock the feature
                            isPremium = true
                        }) {
                            Text("Unlock Premium")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 12)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.29, green: 0.55, blue: 0.9),  // Instagram blue
                                            Color(red: 0.76, green: 0.21, blue: 0.54)  // Instagram purple
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(5)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Shower Beer")
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Communities View
struct CommunitiesView: View {
    // Premium feature
    @State private var isPremium = false
    @State private var selectedServer = 0
    
    // Discord-like servers
    let servers = [
        "Indie Rock",
        "80's Synth",
        "Hip Hop",
        "Jazz",
        "EDM"
    ]
    
    // Discord-like channels
    let channels = [
        ["general", "song-requests", "new-releases", "band-discussion"],
        ["synthwave", "new-retro", "outrun", "recommendations"],
        ["beats", "lyrics", "producers", "hip-hop-history"],
        ["bebop", "fusion", "contemporary", "classics"],
        ["house", "techno", "trance", "drum-n-bass"]
    ]
    
    var body: some View {
        ZStack {
            // Discord-like layout
            HStack(spacing: 0) {
                // Server sidebar
                VStack(spacing: 15) {
                    ForEach(0..<servers.count, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedServer = index
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(selectedServer == index ? Color.neonBlue : Color.gray.opacity(0.3))
                                    .frame(width: 50, height: 50)
                                
                                Text(String(servers[index].prefix(1)))
                                    .font(.futuristicTitle)
                                    .foregroundColor(.white)
                            }
                            .overlay(
                                Circle()
                                    .stroke(selectedServer == index ? Color.white : Color.clear, lineWidth: 2)
                                    .padding(2)
                            )
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: 70)
                .padding(.vertical)
                .background(Color(.systemGray6))
                
                // Channels list
                VStack(alignment: .leading, spacing: 5) {
                    Text(servers[selectedServer])
                        .font(.futuristicTitle)
                        .padding()
                    
                    Divider()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("TEXT CHANNELS")
                                .font(.futuristicCaption)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                            
                            ForEach(channels[selectedServer], id: \.self) { channel in
                                HStack {
                                    Image(systemName: "number")
                                        .foregroundColor(.gray)
                                    
                                    Text(channel)
                                        .font(.futuristicBody)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                                .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            // Premium lock overlay
            if !isPremium {
                ZStack {
                    Color.black.opacity(0.85)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .shadow(color: Color.neonBlue, radius: 10, x: 0, y: 0)
                        
                        Text("Premium Feature")
                            .font(.futuristicTitle)
                            .foregroundColor(.white)
                        
                        Text("Upgrade to TuneBoxed Premium to access Communities")
                            .font(.futuristicBody)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal)
                        
                        Button(action: {
                            // For demo purposes, unlock the feature
                            isPremium = true
                        }) {
                            Text("Unlock Premium")
                                .font(.futuristicHeadline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 12)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.neonBlue, .neonPink]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(25)
                                .shadow(color: Color.neonBlue.opacity(0.7), radius: 10, x: 0, y: 0)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Communities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Song of Day View
struct SongOfDayView: View {
    // Random genre for the day
    @State private var dailyGenre = ["80's Pop", "90's Grunge", "70's Rock", "Hip Hop", "EDM", "Jazz", "Classical", "R&B", "Country", "Indie Rock"].randomElement() ?? "80's Pop"
    @State private var isLoading = true
    @State private var showGenreTitle = false
    
    // Sample genre-related posts
    var genrePosts: [Post] {
        // Generate posts based on the daily genre
        let artists: [String]
        let songTitles: [String]
        
        switch dailyGenre {
        case "80's Pop":
            artists = ["Michael Jackson", "Madonna", "Prince", "Whitney Houston", "Duran Duran"]
            songTitles = ["Billie Jean", "Like a Prayer", "Purple Rain", "I Wanna Dance With Somebody", "Hungry Like the Wolf"]
        case "90's Grunge":
            artists = ["Nirvana", "Pearl Jam", "Soundgarden", "Alice in Chains", "Stone Temple Pilots"]
            songTitles = ["Smells Like Teen Spirit", "Even Flow", "Black Hole Sun", "Man in the Box", "Plush"]
        case "70's Rock":
            artists = ["Led Zeppelin", "Queen", "Pink Floyd", "The Eagles", "Fleetwood Mac"]
            songTitles = ["Stairway to Heaven", "Bohemian Rhapsody", "Comfortably Numb", "Hotel California", "Dreams"]
        case "Hip Hop":
            artists = ["Kendrick Lamar", "Drake", "J. Cole", "Kanye West", "Tyler, The Creator"]
            songTitles = ["HUMBLE.", "God's Plan", "Middle Child", "Stronger", "EARFQUAKE"]
        default:
            artists = ["Various Artists", "Unknown Artist", "The Musicians", "Studio Band", "Indie Group"]
            songTitles = ["Amazing Track", "Best Song Ever", "Can't Stop Listening", "Dance All Night", "Epic Tune"]
        }
        
        // Create posts with the genre-specific artists and songs
        var posts: [Post] = []
        for i in 0..<min(artists.count, songTitles.count) {
            posts.append(Post(
                songTitle: songTitles[i],
                artist: artists[i],
                username: ["musiclover", "genrefan", "boxzr", "tuneboxed", "soundhunter"][i % 5],
                likes: Int.random(in: 50...1500),
                type: i == 0 ? .songOfDay : .regular,
                genre: dailyGenre
            ))
        }
        
        return posts
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Daily Genre Banner
                ZStack {
                    Rectangle()
                        .fill(Color.futuristicGradient)
                        .frame(height: 80)
                    
                    VStack {
                        HStack {
                            Image(systemName: "music.note")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                            Text("TODAY'S GENRE")
                                .font(.futuristicCaption)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Text(dailyGenre)
                            .font(.futuristicTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .scaleEffect(showGenreTitle ? 1.0 : 0.8)
                            .opacity(showGenreTitle ? 1.0 : 0.0)
                            .onAppear {
                                withAnimation(.spring().delay(0.3)) {
                                    showGenreTitle = true
                                }
                            }
                    }
                }
                
                // Loading indicator
                if isLoading {
                    VStack(spacing: 20) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .neonBlue))
                            .scaleEffect(1.5)
                        
                        Text("Finding the best \(dailyGenre) tracks...")
                            .font(.futuristicSubheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 50)
                    .onAppear {
                        // Simulate loading
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isLoading = false
                            }
                        }
                    }
                } else {
                    // Shorter genre description
                    VStack(alignment: .leading) {
                        Text("About \(dailyGenre)")
                            .font(.futuristicHeadline)
                            .padding(.horizontal)
                        
                        Text(genreShortDescription)
                            .font(.futuristicBody)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .lineLimit(2)
                    }
                    .padding(.top, 10)
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Top tracks in this genre
                    Text("Top \(dailyGenre) Tracks")
                        .font(.futuristicTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    ForEach(genrePosts, id: \.id) { post in
                        PostView(post: post)
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.9).combined(with: .opacity).animation(.spring().delay(Double(genrePosts.firstIndex(where: { $0.id == post.id }) ?? 0) * 0.1)),
                                removal: .opacity
                            ))
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Song of Day")
    }
    
    // Shorter genre descriptions
    private var genreShortDescription: String {
        switch dailyGenre {
        case "80's Pop":
            return "Synthesizers, big hair, and catchy melodies defined the MTV era."
        case "90's Grunge":
            return "Seattle-born, angsty rock with distorted guitars and raw vocals."
        case "70's Rock":
            return "The golden age of rock that gave us iconic anthems and bands."
        case "Hip Hop":
            return "A cultural movement with rap, beats, and innovative sampling."
        case "EDM":
            return "Energy-driven electronic beats designed for movement and dancing."
        case "Jazz":
            return "America's classical music known for improvisation and swing."
        default:
            return "A unique sound that has influenced artists across generations."
        }
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @State private var selectedSegment = 0
    let segments = ["Posts", "Playlists", "Communities"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Cover photo with adjusted layout
                ZStack(alignment: .top) {
                    // Cover photo background
                    Rectangle()
                        .fill(Color.tuneBoxedGradient)
                        .frame(height: 170)
                    
                    // Profile content
                    VStack(spacing: 0) {
                        // Profile photo and badge
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 100, height: 100)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            
                            Circle()
                                .fill(Color.tuneBoxedGradient)
                                .frame(width: 94, height: 94)
                                .overlay(
                                    Text("B")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40, weight: .bold, design: .rounded))
                                )
                            
                            // Verified badge - Instagram style
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                                .background(Circle().fill(Color.white).frame(width: 22, height: 22))
                                .font(.system(size: 20))
                                .offset(x: 35, y: 35)
                        }
                        .offset(y: 65)
                        .zIndex(1)
                        
                        // Profile info
                        VStack(spacing: 4) {
                            Spacer(minLength: 60)
                            
                            HStack {
                                Text("boxzr")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 14))
                            }
                            
                            Text("Shower beer enthusiast")
                                .font(.instagramSubheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.bottom, 15)
                            
                            // Stats in Instagram style
                            HStack(spacing: 0) {
                                Spacer()
                                VStack(spacing: 4) {
                                    Text("12")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("Posts")
                                        .font(.instagramCaption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                VStack(spacing: 4) {
                                    Text("245")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("Followers")
                                        .font(.instagramCaption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                VStack(spacing: 4) {
                                    Text("189")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("Following")
                                        .font(.instagramCaption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            
                            // Edit Profile Button - Instagram style
                            Button(action: {}) {
                                Text("Edit Profile")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(5)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 12)
                        }
                        .background(Color(.systemBackground))
                    }
                }
                
                // Segmented control - Instagram style
                HStack {
                    ForEach(0..<segments.count, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedSegment = index
                            }
                        }) {
                            VStack(spacing: 10) {
                                Spacer()
                                
                                Text(segments[index].uppercased())
                                    .font(.system(size: 12, weight: selectedSegment == index ? .semibold : .regular))
                                    .foregroundColor(selectedSegment == index ? .black : .gray)
                                
                                Rectangle()
                                    .fill(selectedSegment == index ? Color.black : Color.clear)
                                    .frame(height: 1)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 44)
                .background(Color(.systemBackground))
                
                // Content with the same structure
                if selectedSegment == 0 {
                    // Posts
                    VStack(alignment: .leading) {
                        ForEach(samplePosts.filter { $0.username == "boxzr" }, id: \.id) { post in
                            PostView(post: post)
                        }
                    }
                    .padding(.top, 8)
                } else if selectedSegment == 1 {
                    // Playlists
                    VStack(alignment: .leading, spacing: 16) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(["Shower Beer Favorites", "Workout Mix", "Chill Vibes", "Road Trip"], id: \.self) { playlist in
                                    VStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.tuneBoxedGradient)
                                            .frame(width: 160, height: 160)
                                            .overlay(
                                                VStack {
                                                    Spacer()
                                                    Text(playlist)
                                                        .font(.instagramHeadline)
                                                        .foregroundColor(.white)
                                                        .multilineTextAlignment(.center)
                                                        .padding()
                                                }
                                            )
                                        
                                        Text("\(Int.random(in: 5...20)) songs")
                                            .font(.instagramCaption)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 4)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                    }
                } else {
                    // Communities
                    VStack(alignment: .leading) {
                        ForEach(communities, id: \.self) { community in
                            HStack {
                                Circle()
                                    .fill(Color.tuneBoxedGradient)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(String(community.prefix(1)).uppercased())
                                            .foregroundColor(.white)
                                            .font(.instagramHeadline)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(community)
                                        .font(.instagramHeadline)
                                    
                                    Text("\(Int.random(in: 100...5000)) members")
                                        .font(.instagramCaption)
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
                    .padding(.top, 8)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
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
    @State private var tabBarVisible = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                NavigationView {
                    SongOfDayView()
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily")
                }
                .tag(0)
                
                NavigationView {
                    FeedView()
                }
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Feed")
                }
                .tag(1)
                
                NavigationView {
                    ShowerBeerView()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "drop.fill")
                        Text("Shower Beer")
                        Image(systemName: "lock.fill")
                            .font(.system(size: 10))
                    }
                }
                .tag(2)
                
                NavigationView {
                    CommunitiesView()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Communities")
                        Image(systemName: "lock.fill")
                            .font(.system(size: 10))
                    }
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
            .opacity(tabBarVisible ? 1 : 0)
            .onAppear {
                // Animate tab bar appearance after launch screen dismisses
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        tabBarVisible = true
                    }
                }
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