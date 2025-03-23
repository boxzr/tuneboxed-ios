import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack {
            // Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Content
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    // Loading state
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                } else {
                    // Post list
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.posts) { post in
                                PostCard(post: post, onLike: { viewModel.likePost(postId: post.id) })
                                    .padding(.bottom, 15)
                            }
                        }
                        .padding(.horizontal, 0)
                    }
                    .refreshable {
                        viewModel.refreshFeed()
                    }
                }
            }
        }
        .navigationTitle("TuneBoxed")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Action for new post
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title3)
                        .foregroundColor(.neonBlue)
                }
            }
        }
    }
}

// Post Card Component
struct PostCard: View {
    let post: Post
    let onLike: () -> Void
    
    @State private var isPlaying = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User info header
            HStack {
                // Profile image
                Circle()
                    .fill(Color.neonBlue.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(post.username)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if post.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.neonBlue)
                                .font(.caption)
                        }
                    }
                    
                    Text("@\(post.username)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Time posted
                Text(formatRelativeTime(date: post.timePosted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            .padding(.top, 10)
            
            // Music player card
            VStack {
                HStack(spacing: 15) {
                    // Album art
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                           startPoint: .topLeading, 
                                           endPoint: .bottomTrailing))
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        )
                    
                    // Track info
                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.songTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Text(post.artistName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    // Play/pause button
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Circle()
                            .fill(Color.neonBlue)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, isPlaying ? 0 : 2)
                            )
                    }
                }
                .padding(10)
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.neonBlue.opacity(0.5), Color.neonPink.opacity(0.5)]), 
                                             startPoint: .topLeading, 
                                             endPoint: .bottomTrailing), 
                               lineWidth: 1)
                )
                .padding(.horizontal, 15)
                
                // Playback progress bar
                if isPlaying {
                    VStack(spacing: 2) {
                        // Animated waveform (simplified)
                        HStack(spacing: 3) {
                            ForEach(0..<20, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 1)
                                    .fill(Color.neonBlue.opacity(Double.random(in: 0.3...1.0)))
                                    .frame(width: 2, height: CGFloat.random(in: 3...15))
                            }
                        }
                        .frame(height: 15)
                        .padding(.horizontal, 15)
                        
                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 3)
                                
                                Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                                       startPoint: .leading, 
                                                       endPoint: .trailing))
                                    .frame(width: geometry.size.width * 0.4, height: 3)
                            }
                        }
                        .frame(height: 3)
                        .padding(.horizontal, 15)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            // Caption
            if !post.postDescription.isEmpty {
                Text(post.postDescription)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.horizontal, 15)
            }
            
            // Action buttons
            HStack(spacing: 20) {
                // Like button
                Button(action: onLike) {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.system(size: 16))
                        Text("\(post.likes)")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
                
                // Comment button
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.right")
                            .font(.system(size: 16))
                        Text("\(post.comments)")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
                
                // Share button
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Save button
                Button(action: {}) {
                    Image(systemName: "bookmark")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        }
        .background(Color(UIColor.systemGray6).opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal, 15)
    }
    
    // Format relative time for display
    private func formatRelativeTime(date: Date) -> String {
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