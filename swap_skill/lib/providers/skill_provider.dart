import 'package:flutter/material.dart';
import '../models/skill.dart';

class SkillProvider extends ChangeNotifier {
  List<Skill> _skills = [];
  List<Skill> _userSkills = [];
  bool _isLoading = false;
  String _selectedCategory = 'All';

  List<Skill> get skills => _skills;
  List<Skill> get userSkills => _userSkills;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  List<Skill> get filteredSkills {
    if (_selectedCategory == 'All') {
      return _skills;
    }
    return _skills.where((skill) => skill.category == _selectedCategory).toList();
  }

  List<String> get categories {
    final categories = _skills.map((skill) => skill.category).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }

  // Mock skills data
  final List<Skill> _mockSkills = [
    Skill(
      id: '1',
      title: 'Flutter Development',
      description: 'Learn to build beautiful cross-platform mobile apps with Flutter and Dart.',
      category: 'Programming',
      userId: '1',
      userName: 'John Doe',
      userRating: 4.8,
      tags: ['Mobile', 'Dart', 'Cross-platform'],
      difficulty: 'Intermediate',
      estimatedHours: 20,
      location: 'New York, NY',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Skill(
      id: '2',
      title: 'UI/UX Design',
      description: 'Master the principles of user interface and user experience design.',
      category: 'Design',
      userId: '2',
      userName: 'Sarah Wilson',
      userProfileImage: null,
      userRating: 4.9,
      tags: ['Design', 'Figma', 'Prototyping'],
      difficulty: 'Beginner',
      estimatedHours: 15,
      location: 'San Francisco, CA',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Skill(
      id: '3',
      title: 'Photography',
      description: 'Learn professional photography techniques and composition.',
      category: 'Arts',
      userId: '3',
      userName: 'Mike Johnson',
      userProfileImage: null,
      userRating: 4.7,
      tags: ['Photography', 'Composition', 'Lighting'],
      difficulty: 'Beginner',
      estimatedHours: 12,
      location: 'Los Angeles, CA',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Skill(
      id: '4',
      title: 'Cooking',
      description: 'Learn to cook delicious meals from around the world.',
      category: 'Lifestyle',
      userId: '4',
      userName: 'Emma Davis',
      userProfileImage: null,
      userRating: 4.6,
      tags: ['Cooking', 'Recipes', 'International'],
      difficulty: 'Beginner',
      estimatedHours: 8,
      location: 'Chicago, IL',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Skill(
      id: '5',
      title: 'Guitar Lessons',
      description: 'Learn to play guitar from basic chords to advanced techniques.',
      category: 'Music',
      userId: '5',
      userName: 'Alex Brown',
      userProfileImage: null,
      userRating: 4.5,
      tags: ['Guitar', 'Music', 'Instruments'],
      difficulty: 'Beginner',
      estimatedHours: 10,
      location: 'Austin, TX',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Future<void> loadSkills() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _skills = _mockSkills;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadUserSkills(String userId) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _userSkills = _skills.where((skill) => skill.userId == userId).toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addSkill(Skill skill) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _skills.insert(0, skill);
    if (skill.userId == '1') { // Current user
      _userSkills.insert(0, skill);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateSkill(Skill skill) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final skillIndex = _skills.indexWhere((s) => s.id == skill.id);
    if (skillIndex != -1) {
      _skills[skillIndex] = skill;
    }

    final userSkillIndex = _userSkills.indexWhere((s) => s.id == skill.id);
    if (userSkillIndex != -1) {
      _userSkills[userSkillIndex] = skill;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteSkill(String skillId) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _skills.removeWhere((skill) => skill.id == skillId);
    _userSkills.removeWhere((skill) => skill.id == skillId);

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Skill> searchSkills(String query) {
    if (query.isEmpty) return filteredSkills;
    
    return filteredSkills.where((skill) =>
      skill.title.toLowerCase().contains(query.toLowerCase()) ||
      skill.description.toLowerCase().contains(query.toLowerCase()) ||
      skill.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }
} 