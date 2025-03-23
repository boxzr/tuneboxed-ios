import SwiftUI

struct LoadingView: View {
    // Animation properties
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.7
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.neonBlue.opacity(0.4), Color.black]), 
                          startPoint: .topLeading, 
                          endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            // Content
            VStack(spacing: 30) {
                // App logo with rings
                ZStack {
                    // Outer rotating ring
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.neonBlue, Color.neonPink]), 
                                              startPoint: .topLeading, 
                                              endPoint: .bottomTrailing), 
                                lineWidth: 4)
                        .frame(width: 140, height: 140)
                        .rotationEffect(.degrees(rotation))
                        .opacity(opacity)
                    
                    // Middle rotating ring
                    Circle()
                        .stroke(Color.neonBlue, lineWidth: 3)
                        .frame(width: 110, height: 110)
                        .rotationEffect(.degrees(-rotation * 0.5))
                        .opacity(opacity + 0.1)
                    
                    // Inner rotating ring
                    Circle()
                        .stroke(Color.neonPink, lineWidth: 2)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(rotation * 0.8))
                        .opacity(opacity + 0.2)
                    
                    // App icon
                    Image(systemName: "music.note")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(rotation * 0.1))
                        .scaleEffect(scale)
                }
                
                // App name
                Text("TuneBoxed")
                    .font(.futuristicTitle)
                    .foregroundColor(.white)
                    .shadow(color: .neonBlue, radius: 5, x: 0, y: 0)
                
                // Progress indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(.top, 10)
                
                // Loading text
                Text("Tuning your experience...")
                    .font(.futuristicSubheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 5)
            }
        }
        .onAppear {
            // Start animations
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                rotation = 360
                scale = 1.0
                opacity = 1.0
            }
        }
    }
} 