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
    Post(songTitle: "Whole Lotta Red", artist: "Playboi Carti", username: "playboicarti", likes: 18723, type: .regular, genre: "Hip Hop"),
    Post(songTitle: "Rebel Yell", artist: "Billy Idol", username: "billyidol", likes: 5642, type: .regular, genre: "80's Rock"),
    Post(songTitle: "Octopus's Garden", artist: "The Beatles", username: "ringostarr", likes: 12086, type: .regular, genre: "60's Rock"),
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
    @State private var logoScale: CGFloat = 0.8
    @State private var textOpacity: Double = 0.0
    @State private var progress = 0.0
    
    var body: some View {
        ZStack {
            // Clean white background like Tinder
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Logo container - exactly like Tinder's style
                ZStack {
                    // Glowing outer circle
                    Circle()
                        .fill(Color.logoMain.opacity(0.1))
                        .frame(width: 110, height: 110)
                    
                    // Progress ring around logo
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.logoMain, Color.logoAccent]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .frame(width: 102, height: 102)
                        .rotationEffect(Angle(degrees: -90))
                    
                    // White background for logo
                    Circle()
                        .fill(Color.white)
                        .frame(width: 90, height: 90)
                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                    // The logo itself
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .scaleEffect(logoScale)
                }
                .padding(.top, 40)
                
                // App Name - Tinder style
                Text("TuneBoxed")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(Color.logoMain)
                    .opacity(textOpacity)
                
                // Updated tagline as requested
                Text("Your music taste, your sound.")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.gray.opacity(0.7))
                    .opacity(textOpacity)
                
                Spacer()
                
                // Tinder-style loading indicator at bottom
                HStack(spacing: 8) {
                    ForEach(0..<3) { i in
                        Circle()
                            .fill(Color.logoMain)
                            .frame(width: 8, height: 8)
                            .opacity(0.2 + (Double(i) * 0.3))
                    }
                }
                .padding(.bottom, 50)
            }
            .padding()
        }
        .onAppear {
            // Start animations
            withAnimation(Animation.spring(dampingFraction: 0.7).delay(0.2)) {
                logoScale = 1.0
            }
            
            withAnimation(Animation.easeIn(duration: 0.8).delay(0.3)) {
                textOpacity = 1.0
            }
            
            // Animate the progress ring
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                withAnimation {
                    if progress < 1.0 {
                        progress += 0.01
                    } else {
                        timer.invalidate()
                    }
                }
            }
            
            // Dismiss launch screen after 4 seconds (extended from 2.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
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
                
                if post.username == "boxzr" || post.username == "playboicarti" || post.username == "billyidol" || post.username == "ringostarr" {
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
    @State private var selectedMusicService = 0
    
    // Sample shower beer playlist
    let showerBeerSongs = [
        (title: "Blinding Lights", artist: "The Weeknd", duration: "3:20", service: "Spotify"),
        (title: "Levitating", artist: "Dua Lipa", duration: "3:23", service: "Apple Music"),
        (title: "Heat Waves", artist: "Glass Animals", duration: "3:58", service: "Spotify"),
        (title: "Watermelon Sugar", artist: "Harry Styles", duration: "2:54", service: "Apple Music"),
        (title: "Don't Start Now", artist: "Dua Lipa", duration: "3:03", service: "Spotify")
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
                                
                                // Music service picker
                                Picker("Music Service", selection: $selectedMusicService) {
                                    Text("Spotify").tag(0)
                                    Text("Apple Music").tag(1)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(8)
                                .padding(.top, 8)
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
                                
                                // Music service icon
                                HStack {
                                    Image(systemName: showerBeerSongs[index].service == "Spotify" ? "s.circle.fill" : "applelogo")
                                        .foregroundColor(showerBeerSongs[index].service == "Spotify" ? Color(red: 0.11, green: 0.73, blue: 0.33) : .black)
                                    
                                    Text(showerBeerSongs[index].duration)
                                        .font(.instagramCaption)
                                        .foregroundColor(.gray)
                                }
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
    
    // Futuristic servers with better names
    let servers = [
        "Indie Revolution",
        "Synth Dimension", 
        "Hip Hop Universe",
        "Jazz Odyssey",
        "EDM Collective"
    ]
    
    // Discord-like channels
    let channels = [
        ["general-chat", "song-recommendations", "new-releases", "artist-spotlight"],
        ["retro-wave", "cyber-synth", "analog-vibes", "track-showcase"],
        ["beat-production", "lyrical-masters", "underground", "sampling"],
        ["classic-revival", "modern-fusion", "live-sessions", "theory-talk"],
        ["house-nation", "techno-realm", "bass-dimension", "festival-talk"]
    ]
    
    // Celebrity users with profiles
    let celebrities = [
        (name: "playboicarti", displayName: "Playboi Carti", isVerified: true, followers: "8.2M"),
        (name: "billyidol", displayName: "Billy Idol", isVerified: true, followers: "2.4M"),
        (name: "ringostarr", displayName: "Ringo Starr", isVerified: true, followers: "5.7M")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Minimal navigation header
            HStack {
                Text("Communities")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "sparkles")
                    .foregroundColor(Color.logoMain)
                    .font(.system(size: 22))
            }
            .padding(.horizontal)
            .padding(.top, 15)
            .padding(.bottom, 10)
            
            // Main content
            ZStack {
                // Professional futuristic communities view
                VStack(spacing: 0) {
                    // Server selection - horizontal scrolling icons
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<servers.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.spring()) {
                                        selectedServer = index
                                    }
                                }) {
                                    VStack(spacing: 8) {
                                        // Server icon
                                        ZStack {
                                            Circle()
                                                .fill(
                                                    LinearGradient(
                                                        gradient: selectedServer == index ?
                                                            Gradient(colors: [Color.logoMain, Color.logoAccent]) :
                                                            Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.2)]),
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .frame(width: 65, height: 65)
                                                .shadow(color: selectedServer == index ? Color.logoMain.opacity(0.4) : .clear, radius: 8, x: 0, y: 0)
                                            
                                            Text(String(servers[index].prefix(1)))
                                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                                .foregroundColor(.white)
                                        }
                                        
                                        // Server name
                                        Text(servers[index])
                                            .font(.system(size: 12, weight: selectedServer == index ? .semibold : .medium))
                                            .foregroundColor(selectedServer == index ? .primary : .gray)
                                            .lineLimit(1)
                                    }
                                    .frame(width: 80)
                                    .scaleEffect(selectedServer == index ? 1.1 : 1.0)
                                    .animation(.spring(), value: selectedServer)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 15)
                    }
                    
                    Divider()
                    
                    // Active community display
                    VStack(alignment: .leading, spacing: 0) {
                        // Community header
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.logoMain, Color.logoAccent]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 40, height: 40)
                                
                                Text(servers[selectedServer].prefix(1))
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(servers[selectedServer])
                                    .font(.system(size: 18, weight: .bold))
                                
                                Text("\(Int.random(in: 1200...8500)) members")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                    .padding(8)
                                    .background(Circle().fill(Color(.systemGray6)))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        
                        // Member tabs
                        HStack(spacing: 0) {
                            ForEach(["Channels", "Members", "About"], id: \.self) { tab in
                                Button(action: {}) {
                                    Text(tab)
                                        .font(.system(size: 14, weight: tab == "Channels" ? .semibold : .regular))
                                        .foregroundColor(tab == "Channels" ? .primary : .gray)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(tab == "Channels" ? Color(.systemGray6) : Color.clear)
                                }
                            }
                        }
                        .background(Color(.systemGray6).opacity(0.3))
                        
                        // Celebrity featured section
                        ScrollView {
                            VStack(alignment: .leading, spacing: 5) {
                                // Featured artists
                                Text("FEATURED ARTISTS")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.logoMain)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 16)
                                    .padding(.bottom, 8)
                                
                                ForEach(celebrities, id: \.name) { celebrity in
                                    HStack(spacing: 12) {
                                        // Avatar
                                        ZStack {
                                            Circle()
                                                .fill(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [Color.logoMain.opacity(0.6), Color.logoAccent.opacity(0.6)]),
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .frame(width: 44, height: 44)
                                            
                                            Text(String(celebrity.name.prefix(1).uppercased()))
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .foregroundColor(.white)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            // Username with verified badge
                                            HStack(spacing: 4) {
                                                Text("@\(celebrity.name)")
                                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                                    .foregroundColor(.primary)
                                                
                                                if celebrity.isVerified {
                                                    Image(systemName: "checkmark.seal.fill")
                                                        .foregroundColor(.blue)
                                                        .font(.system(size: 14))
                                                }
                                            }
                                            
                                            // Display name and followers
                                            Text("\(celebrity.displayName) • \(celebrity.followers) followers")
                                                .font(.system(size: 12, design: .rounded))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        // Follow button
                                        Button(action: {}) {
                                            Text("Follow")
                                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(Color.logoMain)
                                                .cornerRadius(16)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.black.opacity(0.02))
                                    .cornerRadius(12)
                                    .padding(.horizontal, 8)
                                }
                                
                                // Channels section
                                Text("TEXT CHANNELS")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.logoMain)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 20)
                                    .padding(.bottom, 8)
                                
                                ForEach(channels[selectedServer], id: \.self) { channel in
                                    HStack {
                                        Image(systemName: "number")
                                            .foregroundColor(Color.logoMain.opacity(0.7))
                                        
                                        Text(channel)
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                            .foregroundColor(.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "person.2")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                        
                                        Text("\(Int.random(in: 2...25))")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.black.opacity(0.03))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 8)
                                }
                            }
                            .padding(.bottom, 100) // Extra padding for premium overlay
                        }
                    }
                    .background(Color(.systemBackground))
                }
                .opacity(0.6) // Make the content slightly visible under premium lock
                
                // Premium overlay with blur effect
                ZStack {
                    // Modern blur effect
                    BlurView(style: .systemThinMaterialDark)
                        .ignoresSafeArea()
                    
                    // Glass card
                    VStack(spacing: 24) {
                        // Premium badge
                        ZStack {
                            // Animated gradient backdrop
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.logoMain.opacity(0.3), Color.logoAccent.opacity(0.3)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)
                            
                            // Lock icon with gradient background
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.logoMain, Color.logoAccent]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "lock.fill")
                                        .font(.system(size: 35))
                                        .foregroundColor(.white)
                                )
                                .shadow(color: Color.logoMain.opacity(0.5), radius: 15, x: 0, y: 0)
                        }
                        
                        VStack(spacing: 8) {
                            Text("Premium Feature")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Connect with your favorite artists in private communities")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.horizontal)
                        }
                        
                        // Features highlight
                        VStack(alignment: .leading, spacing: 14) {
                            premiumFeatureRow(icon: "person.3.fill", text: "Join private artist communities")
                            premiumFeatureRow(icon: "music.mic", text: "Chat with verified artists")
                            premiumFeatureRow(icon: "music.note.list", text: "Exclusive listening parties")
                        }
                        .padding(.top, 5)
                        
                        // Get premium button
                        Button(action: {
                            // For demo purposes, unlock the feature
                            isPremium = true
                        }) {
                            Text("Get Premium")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.logoMain, Color.logoAccent]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(30)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .padding(.top, 10)
                        
                        // "No Thanks" button
                        Button(action: {}) {
                            Text("Not Now")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.top, 5)
                        }
                    }
                    .padding(30)
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.3),
                                        Color.white.opacity(0.1),
                                        Color.clear,
                                        Color.white.opacity(0.1)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    .padding(20)
                }
            }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
    
    // Premium feature row
    private func premiumFeatureRow(icon: String, text: String) -> some View {
        HStack(spacing: 15) {
            // Icon with gradient fill
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 16))
            
            Spacer()
        }
    }
}

// UIKit Blur support
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

// Visual Effect View for glass effect
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
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
                            
                            Text("I love the game, I love the hustle")
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
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