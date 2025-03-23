import SwiftUI

// MARK: - Color Extensions
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