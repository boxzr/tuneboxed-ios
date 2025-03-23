import SwiftUI

@main
struct TuneBoxedSimpleApp: App {
    // Create shared view model instances
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            if case .authenticated(let user) = authViewModel.authState {
                if authViewModel.showLoadingScreen {
                    LoadingView()
                } else {
                    AppContentWrapper(user: user)
                }
            } else {
                if authViewModel.isShowingSignUp {
                    SignUpView()
                } else {
                    LoginView()
                }
            }
        }
    }
} 