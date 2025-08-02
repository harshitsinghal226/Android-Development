import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  // Mock user data for demo
  final User _mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    profileImage: null,
    bio: 'Passionate about teaching and learning new skills!',
    skills: ['Flutter Development', 'UI/UX Design', 'Photography'],
    interests: ['Mobile Development', 'Design', 'Travel'],
    rating: 4.8,
    completedSwaps: 12,
    location: 'New York, NY',
    joinedDate: DateTime.now().subtract(const Duration(days: 30)),
  );

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock login logic
    if (email == 'john@example.com' && password == 'password') {
      _currentUser = _mockUser;
      _isAuthenticated = true;
    } else {
      throw Exception('Invalid credentials');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock registration logic
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      profileImage: null,
      bio: '',
      skills: [],
      interests: [],
      rating: 0.0,
      completedSwaps: 0,
      location: '',
      joinedDate: DateTime.now(),
    );
    _isAuthenticated = true;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = null;
    _isAuthenticated = false;

    _isLoading = false;
    notifyListeners();
  }

  void updateUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void updateProfile({
    String? name,
    String? bio,
    String? location,
    List<String>? skills,
    List<String>? interests,
  }) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        bio: bio,
        location: location,
        skills: skills,
        interests: interests,
      );
      notifyListeners();
    }
  }
} 