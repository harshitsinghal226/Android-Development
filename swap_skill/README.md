# SwapSkill - Skill Swapping Platform

A modern Flutter app that allows users to trade and exchange skills with each other. Built with a clean architecture, modern UI design, and comprehensive features.

## Features

### 🔐 Authentication
- User registration and login
- Secure authentication flow
- Profile management

### 🎯 Skill Management
- Browse available skills
- Add new skills to the platform
- Search and filter skills by category, difficulty, and location
- Detailed skill information with ratings and reviews

### 🔄 Skill Swapping
- Request skill swaps with other users
- Track swap status (pending, active, completed)
- Manage swap history

### 👤 User Profiles
- Complete user profiles with skills and interests
- User ratings and reviews
- Profile customization

### 🔍 Advanced Search
- Search by skill name, description, or tags
- Filter by category and difficulty
- Location-based filtering

## Screens

1. **Login Screen** - User authentication with demo credentials
2. **Register Screen** - New user registration
3. **Home Screen** - Main navigation with bottom tabs
4. **Skills Screen** - Browse and discover skills
5. **Search Screen** - Advanced search with filters
6. **Swaps Screen** - Manage skill exchanges
7. **Profile Screen** - User profile and settings
8. **Skill Detail Screen** - Detailed skill information
9. **Add Skill Screen** - Create new skill listings

## Architecture

### Models
- `User` - User data and profile information
- `Skill` - Skill listings with metadata
- `Swap` - Skill exchange transactions

### Providers (State Management)
- `AuthProvider` - Authentication and user state
- `SkillProvider` - Skill data and operations

### Screens
- Organized by feature with clear separation of concerns
- Responsive design with modern UI components

### Widgets
- Reusable components like `SkillCard`
- Consistent theming and styling

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd swap_skill
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Demo Credentials
- **Email**: john@example.com
- **Password**: password

## Dependencies

- `provider` - State management
- `go_router` - Navigation
- `shared_preferences` - Local storage
- `http` - API communication
- `cached_network_image` - Image caching
- `flutter_svg` - SVG support
- `intl` - Internationalization

## Project Structure

```
lib/
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── utils/           # Utilities and theme
└── main.dart        # App entry point
```

## Features in Detail

### Skill Discovery
- Browse skills by category
- Search functionality
- Filter by difficulty and location
- Skill cards with user information

### User Experience
- Modern Material Design 3
- Smooth animations and transitions
- Responsive layout
- Intuitive navigation

### Data Management
- Mock data for demonstration
- Provider pattern for state management
- Clean separation of concerns

## Future Enhancements

- [ ] Real-time messaging
- [ ] Push notifications
- [ ] Image upload for skills
- [ ] Advanced filtering options
- [ ] User reviews and ratings
- [ ] Location-based matching
- [ ] Video call integration
- [ ] Payment integration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the repository.
