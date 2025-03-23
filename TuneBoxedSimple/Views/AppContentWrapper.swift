import SwiftUI

struct AppContentWrapper: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    let user: User
    
    // Tab state
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home/Feed tab
            NavigationView {
                FeedView()
            }
            .tabItem {
                Image(systemName: "music.note.house.fill")
                Text("Home")
            }
            .tag(0)
            
            // Search tab
            NavigationView {
                Text("Search View - Coming Soon")
                    .font(.futuristicTitle)
                    .foregroundColor(.white)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(1)
            
            // Profile tab
            NavigationView {
                ProfileView(user: user)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(2)
            
            // Settings tab
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
            .tag(3)
        }
        .accentColor(.neonBlue)
        .onAppear {
            // Configure tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            appearance.backgroundColor = UIColor(Color.black.opacity(0.8))
            
            // Configure normal and selected colors
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray
            ]
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(Color.neonBlue)
            ]
            
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.neonBlue)
            
            // Apply the appearance
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// Settings View
struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.neonBlue.opacity(0.2), Color.black]), 
                           startPoint: .topLeading, 
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                List {
                    Section(header: Text("Account").font(.futuristicHeadline)) {
                        Button(action: {
                            // Sign out action
                            authViewModel.signOut()
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.red)
                                Text("Sign Out")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Section(header: Text("About").font(.futuristicHeadline)) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.neonBlue)
                            Text("Version 1.0.0")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.shield")
                                .foregroundColor(.neonBlue)
                            Text("Privacy Policy")
                        }
                        
                        HStack {
                            Image(systemName: "doc.text")
                                .foregroundColor(.neonBlue)
                            Text("Terms of Service")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
} 