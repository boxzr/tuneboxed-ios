import SwiftUI

// MARK: - Font Extensions
extension Font {
    static func instagramFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .rounded)
    }
    
    static let instagramTitle = instagramFont(size: 24, weight: .semibold)
    static let instagramHeadline = instagramFont(size: 16, weight: .semibold)
    static let instagramSubheadline = instagramFont(size: 14, weight: .medium)
    static let instagramBody = instagramFont(size: 14, weight: .regular)
    static let instagramCaption = instagramFont(size: 12, weight: .regular)
    
    // Futuristic fonts
    static func futuristicFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .rounded)
    }
    
    static let futuristicTitle = futuristicFont(size: 24, weight: .bold)
    static let futuristicHeadline = futuristicFont(size: 18, weight: .semibold)
    static let futuristicSubheadline = futuristicFont(size: 16, weight: .medium)
    static let futuristicBody = futuristicFont(size: 14, weight: .regular)
    static let futuristicCaption = futuristicFont(size: 12, weight: .regular)
} 