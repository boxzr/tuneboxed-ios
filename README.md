# TuneBoxed

TuneBoxed is a social music sharing app that allows users to share and discover music with friends.

## Features

- User authentication (login and signup)
- Futuristic user interface with neon blue/pink themes
- Feed of music posts
- User profiles
- Music playback (simulated)

## Project Structure

The app follows the MVVM (Model-View-ViewModel) architecture for clean separation of concerns:

```
TuneBoxedSimple/
├── App/                      # App entry point and main wrappers
├── Extensions/               # Swift extensions for UI components
├── Models/                   # Data models
├── Services/                 # Network and other services
├── ViewModels/               # Logic for each view
└── Views/                    # UI components
    ├── Auth/                 # Login and registration screens
    ├── Common/               # Shared UI components
    ├── Feed/                 # Home feed related views
    ├── Features/             # Feature-specific views 
    └── Profile/              # User profile related views
```

## Getting Started

### Prerequisites

- Xcode 13.0+
- iOS 15.0+
- Swift 5.5+

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/TuneBoxedSimple.git
```

2. Open the project in Xcode
```bash
cd TuneBoxedSimple
open TuneBoxedSimple.xcodeproj
```

3. Run the project on a simulator or device

## Development

This project is structured with OOP principles in mind:

- **Encapsulation**: Data and methods are encapsulated in appropriate models and view models
- **Inheritance**: UI components extend from base SwiftUI views and implement shared functionality
- **Abstraction**: Complex operations are abstracted into services
- **Polymorphism**: Common interfaces are used for similar operations

## Future Improvements

- Backend integration with a real API
- Audio playback functionality
- User messaging and friend connections
- Music recommendations
- Playlist creation and sharing

## Demo Account

For testing, use the following credentials:
- Email: demo@example.com
- Password: password123

## Technologies Used

- SwiftUI for UI
- Combine for reactive programming
- Swift 5 language features
- MVVM architecture pattern

## Credits

Design inspiration: Instagram, Spotify, and Apple Music

## License

This project is licensed under the MIT License - see the LICENSE file for details. 
