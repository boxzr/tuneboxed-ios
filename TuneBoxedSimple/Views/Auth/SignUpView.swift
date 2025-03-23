import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    // UI states
    @State private var passwordVisible = false
    @FocusState private var focusField: Field?
    
    enum Field {
        case email, fullName, username, password
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.neonBlue.opacity(0.4), Color.black]), 
                           startPoint: .topLeading, 
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            // Sign up content
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
                        
                        Text("Create Account")
                            .font(.futuristicTitle)
                            .foregroundColor(.white)
                            .shadow(color: .neonBlue, radius: 5, x: 0, y: 0)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                    
                    // Sign up form
                    VStack(spacing: 20) {
                        // Email field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Email")
                                .font(.futuristicSubheadline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            TextField("", text: $authViewModel.signUpCredentials.email)
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
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .focused($focusField, equals: .email)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusField = .fullName
                                }
                        }
                        
                        // Full Name field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Full Name")
                                .font(.futuristicSubheadline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            TextField("", text: $authViewModel.signUpCredentials.fullName)
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
                                .focused($focusField, equals: .fullName)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusField = .username
                                }
                        }
                        
                        // Username field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Username")
                                .font(.futuristicSubheadline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            TextField("", text: $authViewModel.signUpCredentials.username)
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
                                .focused($focusField, equals: .username)
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
                                        TextField("", text: $authViewModel.signUpCredentials.password)
                                    } else {
                                        SecureField("", text: $authViewModel.signUpCredentials.password)
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
                                .textContentType(.newPassword)
                                .disableAutocorrection(true)
                                .focused($focusField, equals: .password)
                                .submitLabel(.done)
                                .onSubmit {
                                    if authViewModel.signUpCredentials.isValid() {
                                        authViewModel.signUp()
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
                            
                            // Password strength indicator
                            HStack(spacing: 5) {
                                Text("Strength:")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                                
                                if authViewModel.signUpCredentials.password.isEmpty {
                                    Text("Enter a password")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                } else if authViewModel.isStrongPassword() {
                                    Text("Strong")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                } else if authViewModel.passwordMeetsRequirements() {
                                    Text("Medium")
                                        .font(.caption)
                                        .foregroundColor(.yellow)
                                } else {
                                    Text("Weak - minimum 6 characters")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.top, 5)
                        }
                        
                        // Sign up button
                        Button(action: {
                            authViewModel.signUp()
                        }) {
                            Text("Create Account")
                                .font(.futuristicHeadline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(authViewModel.signUpCredentials.isValid() ? 
                                              LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                                            startPoint: .leading, 
                                                            endPoint: .trailing) :
                                              LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.7)]), 
                                                            startPoint: .leading, 
                                                            endPoint: .trailing))
                                )
                                .shadow(color: authViewModel.signUpCredentials.isValid() ? Color.neonBlue.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 0)
                                .opacity(authViewModel.signUpCredentials.isValid() ? 1.0 : 0.7)
                        }
                        .disabled(!authViewModel.signUpCredentials.isValid())
                        .padding(.top, 10)
                        
                        // Login option
                        HStack {
                            Text("Already have an account?")
                                .font(.futuristicBody)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Button(action: {
                                authViewModel.isShowingSignUp = false
                            }) {
                                Text("Sign In")
                                    .font(.futuristicBody)
                                    .fontWeight(.bold)
                                    .foregroundColor(.neonBlue)
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 30)
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