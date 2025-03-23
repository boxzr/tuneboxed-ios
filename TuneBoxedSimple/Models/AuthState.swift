import Foundation

// MARK: - Authentication Models
enum AuthState {
    case idle
    case loading
    case authenticated(User)
    case unauthenticated
    case error(String)
}

struct SignUpCredentials {
    var email: String = ""
    var fullName: String = ""
    var username: String = ""
    var password: String = ""
    
    func isValid() -> Bool {
        return !email.isEmpty && 
               !fullName.isEmpty && 
               !username.isEmpty && 
               password.count >= 6
    }
}

struct LoginCredentials {
    var email: String = ""
    var password: String = ""
    
    func isValid() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
}

// Password validation utilities
enum PasswordValidation {
    static func meetsMinimumRequirements(_ password: String) -> Bool {
        // Minimum 6 characters
        return password.count >= 6
    }
    
    static func isStrongPassword(_ password: String) -> Bool {
        // At least 8 characters, contains uppercase, lowercase, number, and special character
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasDigit = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasSpecialChar = password.rangeOfCharacter(from: .punctuationCharacters) != nil
        
        return password.count >= 8 && hasUppercase && hasLowercase && hasDigit && hasSpecialChar
    }
} 