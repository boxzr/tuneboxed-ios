import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    // Profile header
                    ProfileHeader(viewModel: viewModel)
                    
                    // Post grid
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                            .padding(.top, 50)
                    } else if viewModel.userPosts.isEmpty {
                        // No posts view
                        VStack(spacing: 20) {
                            Image(systemName: "music.note.list")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            
                            Text("No posts yet")
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            Text("Your music journey will appear here")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 50)
                    } else {
                        // Post grid
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 1),
                            GridItem(.flexible(), spacing: 1),
                            GridItem(.flexible(), spacing: 1)
                        ], spacing: 1) {
                            ForEach(viewModel.userPosts) { post in
                                NavigationLink(destination: Text("Post Detail - Coming Soon")) {
                                    PostThumbnail(post: post)
                                }
                            }
                        }
                        .padding(.top, 1)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Menu action
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

// Profile Header Component
struct ProfileHeader: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 18) {
            // Profile image and stats
            HStack(alignment: .center, spacing: 20) {
                // Profile image
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.neonBlue.opacity(0.7), Color.neonPink.opacity(0.7)]), 
                                       startPoint: .topLeading, 
                                       endPoint: .bottomTrailing))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .opacity(0.5)
                    )
                
                // Stats
                HStack(alignment: .center, spacing: 30) {
                    // Posts
                    VStack(spacing: 5) {
                        Text(viewModel.formatUserStats(count: viewModel.user.posts))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Text("Posts")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Followers
                    VStack(spacing: 5) {
                        Text(viewModel.formatUserStats(count: viewModel.user.followers))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Following
                    VStack(spacing: 5) {
                        Text(viewModel.formatUserStats(count: viewModel.user.following))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.top, 15)
            
            // Name and bio
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(viewModel.user.fullName)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    if viewModel.user.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.neonBlue)
                            .font(.caption)
                    }
                    
                    if viewModel.user.isPremium {
                        Text("PRO")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                                       startPoint: .leading, 
                                                       endPoint: .trailing))
                            )
                            .foregroundColor(.white)
                    }
                }
                
                Text("@\(viewModel.user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let bio = viewModel.user.bio, !bio.isEmpty {
                    Text(bio)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            // Edit Profile Button
            Button(action: {
                viewModel.isEditingProfile = true
            }) {
                Text("Edit Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.vertical, 10)
            .sheet(isPresented: $viewModel.isEditingProfile) {
                EditProfileView(viewModel: viewModel)
            }
            
            // Tab bar for profile content
            HStack {
                Spacer()
                
                // Posts tab
                VStack(spacing: 8) {
                    Image(systemName: "music.note.list")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 1)
                }
                .frame(width: 80)
                
                Spacer()
                
                // Liked tab (inactive)
                VStack(spacing: 8) {
                    Image(systemName: "heart")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 1)
                }
                .frame(width: 80)
                
                Spacer()
                
                // Playlist tab (inactive)
                VStack(spacing: 8) {
                    Image(systemName: "music.note.house")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 1)
                }
                .frame(width: 80)
                
                Spacer()
            }
            .padding(.top, 10)
        }
        .padding(.bottom, 10)
    }
}

// Post Thumbnail Component
struct PostThumbnail: View {
    let post: Post
    
    var body: some View {
        ZStack {
            // Post thumbnail background
            Rectangle()
                .fill(Color.neonBlue.opacity(0.1))
                .aspectRatio(1, contentMode: .fill)
                .overlay(
                    VStack {
                        // Album art placeholder
                        Image(systemName: "music.note")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white.opacity(0.7))
                        
                        // Song title
                        Text(post.songTitle)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .padding(.horizontal, 5)
                        
                        // Artist name
                        Text(post.artistName)
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .padding(.horizontal, 5)
                    }
                )
            
            // Play indicator
            VStack {
                HStack {
                    Spacer()
                    
                    Image(systemName: "music.note")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(4)
                        .padding(5)
                }
                
                Spacer()
            }
        }
    }
}

// Edit Profile View
struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Profile image
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.neonBlue.opacity(0.7), Color.neonPink.opacity(0.7)]), 
                                           startPoint: .topLeading, 
                                           endPoint: .bottomTrailing))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .opacity(0.5)
                        )
                        .overlay(
                            Button(action: {
                                // Action to change profile image
                            }) {
                                Circle()
                                    .fill(Color.black.opacity(0.5))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                    )
                            }
                            .offset(x: 35, y: 35)
                        )
                        .padding(.top, 20)
                    
                    // Edit form
                    VStack(spacing: 25) {
                        // Username
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Username")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("@\(viewModel.user.username)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        // Full Name
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Full Name")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text(viewModel.user.fullName)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        // Bio
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Bio")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            TextEditor(text: $viewModel.updatedBio)
                                .foregroundColor(.white)
                                .padding(10)
                                .frame(height: 120)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .onAppear {
                                    UITextView.appearance().backgroundColor = .clear
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.neonBlue)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateProfile()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.neonBlue)
                    .disabled(viewModel.isLoading)
                }
            }
        }
    }
} 