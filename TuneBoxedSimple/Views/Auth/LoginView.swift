import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    // UI states
    @State private var passwordVisible = false
    @FocusState private var focusField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.neonBlue.opacity(0.4), Color.black]), 
                           startPoint: .topLeading, 
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            // Login content
            ScrollView {
                VStack(spacing: 20) {
                    // App logo
                    VStack(spacing: 15) {
                        Image(systemName: "music.note")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .fill(Color.neonBlue.opacity(0.2))
                                    .overlay(
                                        Circle()
                                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                                                 startPoint: .topLeading, 
                                                                 endPoint: .bottomTrailing), 
                                                   lineWidth: 2)
                                    )
                            )
                            .padding(.bottom, 5)
                        
                        Text("TuneBoxed")
                            .font(.futuristicTitle)
                            .foregroundColor(.white)
                            .shadow(color: .neonBlue, radius: 5, x: 0, y: 0)
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 40)
                    
                    // Login form
                    VStack(spacing: 20) {
                        // Email field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Email")
                                .font(.futuristicSubheadline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            TextField("", text: $authViewModel.loginCredentials.email)
                                .font(.body)
                                .padding()
                                .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.neonBlue.opacity(0.5), Color.neonPink.opacity(0.5)]), 
                                                             startPoint: .topLeading, 
                                                             endPoint: .bottomTrailing), 
                                               lineWidth: 1)
                                )
                                .autocapitalization(.none)
                                .focused($focusField, equals: .email)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusField = .password
                                }
                        }
                        
                        // Password field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password")
                                .font(.futuristicSubheadline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            HStack {
                                Group {
                                    if passwordVisible {
                                        TextField("", text: $authViewModel.loginCredentials.password)
                                    } else {
                                        SecureField("", text: $authViewModel.loginCredentials.password)
                                    }
                                }
                                .font(.body)
                                .padding()
                                .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.neonBlue.opacity(0.5), Color.neonPink.opacity(0.5)]), 
                                                             startPoint: .topLeading, 
                                                             endPoint: .bottomTrailing), 
                                               lineWidth: 1)
                                )
                                .autocapitalization(.none)
                                .textContentType(.password)
                                .disableAutocorrection(true)
                                .focused($focusField, equals: .password)
                                .submitLabel(.done)
                                .onSubmit {
                                    if authViewModel.loginCredentials.isValid() {
                                        authViewModel.login()
                                    }
                                }
                                
                                // Toggle password visibility
                                Button(action: {
                                    passwordVisible.toggle()
                                }) {
                                    Image(systemName: passwordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                .padding(.trailing, 10)
                            }
                        }
                        
                        // Login button
                        Button(action: {
                            authViewModel.login()
                        }) {
                            Text("Sign In")
                                .font(.futuristicHeadline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(authViewModel.loginCredentials.isValid() ? 
                                              LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                                           startPoint: .leading, 
                                                           endPoint: .trailing) :
                                              LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.7)]), 
                                                           startPoint: .leading, 
                                                           endPoint: .trailing))
                                )
                                .shadow(color: authViewModel.loginCredentials.isValid() ? Color.neonBlue.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 0)
                                .opacity(authViewModel.loginCredentials.isValid() ? 1.0 : 0.7)
                        }
                        .disabled(!authViewModel.loginCredentials.isValid())
                        .padding(.top, 10)
                        
                        // Sign up option
                        HStack {
                            Text("Don't have an account?")
                                .font(.futuristicBody)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Button(action: {
                                authViewModel.isShowingSignUp = true
                            }) {
                                Text("Sign Up")
                                    .font(.futuristicBody)
                                    .fontWeight(.bold)
                                    .foregroundColor(.neonBlue)
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.horizontal, 30)
                }
            }
            
            // Demo credentials hint
            VStack {
                Spacer()
                Text("Demo: Email: demo@example.com, Password: password123")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.bottom, 10)
            }
        }
        .alert(isPresented: $authViewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(authViewModel.errorMessage ?? "An unknown error occurred"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
} 