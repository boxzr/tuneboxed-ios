# TuneBoxed Project Summary

This document provides an overview of the TuneBoxed codebase to help new contributors understand the project structure and conventions.

## Application Overview

TuneBoxed is a social music sharing app built with SwiftUI, following the MVVM (Model-View-ViewModel) architecture. The app allows users to share songs they're listening to, discover new music from others, and interact with a music-focused community.

## Code Architecture

### MVVM Pattern

The app is organized following the MVVM pattern:

1. **Models**: Data structures that represent the app's state (User, Post, etc.)
2. **Views**: UI components that display data to the user
3. **ViewModels**: Manage the state and business logic for views

### Directory Structure

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

## Key Components

### Models

- **User.swift**: Represents a user in the app
- **Post.swift**: Represents a music post
- **AuthState.swift**: Models for authentication states and credentials

### ViewModels

- **AuthViewModel.swift**: Manages authentication logic
- **FeedViewModel.swift**: Handles feed display and post actions
- **ProfileViewModel.swift**: Manages profile data and actions

### Views

- **ContentView**: Main app container that handles routing based on auth state
- **LoginView/SignUpView**: Authentication screens
- **FeedView**: Displays the music post feed
- **ProfileView**: Shows user profile and posts
- **LoadingView**: Animated loading screen

### Extensions

- **Color+Extensions.swift**: Custom colors and gradients
- **Font+Extensions.swift**: Typography system
- **View+Extensions.swift**: UI utility extensions

### Services

- **NetworkService.swift**: Handles API communication (currently mocked)

## Object-Oriented Programming Principles

The codebase follows standard OOP principles:

1. **Encapsulation**: Data and functionality are encapsulated in appropriate models and viewModels
2. **Inheritance**: UI components inherit from base SwiftUI components
3. **Abstraction**: Complex operations are abstracted into services
4. **Polymorphism**: Common interfaces for similar components

## Style Guide

- Models use structs when immutability is desired
- ViewModels use classes to leverage ObservableObject
- Extensions are used to keep the codebase modular
- MARK comments are used to organize sections of code

## Authentication Flow

1. User opens app -> Unauthenticated state -> Show login/signup
2. User logs in/signs up -> Loading state -> Show loading screen
3. Authentication completes -> Authenticated state -> Show app content

## Mock Data

The app uses sample data for development purposes:
- Sample user in User.swift
- Sample posts in Post.swift
- Mock authentication in AuthViewModel.swift

## Adding New Features

When adding new features:

1. Add any new models to the Models directory
2. Create ViewModels for new functionality
3. Add UI components to the appropriate Views subdirectory
4. Update any Services as needed
5. Extend existing types using Extensions when appropriate

## Testing

Currently, the app uses manual testing. Add automated tests in the future.

## Roadmap

- Backend integration with real API
- User following/connections
- Music playback
- Search functionality
- Notifications 