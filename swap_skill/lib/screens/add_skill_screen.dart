import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/skill_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/theme.dart';
import '../models/skill.dart';

class AddSkillScreen extends StatefulWidget {
  const AddSkillScreen({super.key});

  @override
  State<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  final _locationController = TextEditingController();
  
  String _selectedCategory = 'Programming';
  String _selectedDifficulty = 'Beginner';
  int _estimatedHours = 10;
  bool _isAvailable = true;

  final List<String> _categories = [
    'Programming',
    'Design',
    'Arts',
    'Music',
    'Lifestyle',
    'Sports',
    'Language',
    'Business',
    'Other',
  ];

  final List<String> _difficulties = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _addSkill() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = context.read<AuthProvider>().currentUser;
    if (currentUser == null) return;

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final skill = Skill(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      userId: currentUser.id,
      userName: currentUser.name,
      userProfileImage: currentUser.profileImage,
      userRating: currentUser.rating,
      tags: tags,
      difficulty: _selectedDifficulty,
      estimatedHours: _estimatedHours,
      location: _locationController.text.trim(),
      isAvailable: _isAvailable,
      createdAt: DateTime.now(),
    );

    try {
      await context.read<SkillProvider>().addSkill(skill);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Skill added successfully!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding skill: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Skill'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: AppTheme.inputDecoration(
                  hintText: 'Enter skill title',
                  labelText: 'Skill Title',
                  prefixIcon: const Icon(Icons.psychology),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a skill title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: AppTheme.inputDecoration(
                  hintText: 'Describe what you can teach...',
                  labelText: 'Description',
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.length < 20) {
                    return 'Description must be at least 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Category
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: AppTheme.inputDecoration(
                  labelText: 'Category',
                  prefixIcon: const Icon(Icons.category),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Difficulty
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                decoration: AppTheme.inputDecoration(
                  labelText: 'Difficulty Level',
                  prefixIcon: const Icon(Icons.trending_up),
                ),
                items: _difficulties.map((difficulty) {
                  return DropdownMenuItem(
                    value: difficulty,
                    child: Text(difficulty),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select difficulty level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Estimated Hours
              Text(
                'Estimated Hours: $_estimatedHours',
                style: AppTheme.body1,
              ),
              Slider(
                value: _estimatedHours.toDouble(),
                min: 1,
                max: 50,
                divisions: 49,
                label: '$_estimatedHours hours',
                onChanged: (value) {
                  setState(() {
                    _estimatedHours = value.round();
                  });
                },
              ),
              const SizedBox(height: 20),

              // Tags
              TextFormField(
                controller: _tagsController,
                decoration: AppTheme.inputDecoration(
                  hintText: 'Enter tags separated by commas',
                  labelText: 'Tags',
                  prefixIcon: const Icon(Icons.tag),
                ),
              ),
              const SizedBox(height: 20),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: AppTheme.inputDecoration(
                  hintText: 'Enter your location',
                  labelText: 'Location',
                  prefixIcon: const Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Available Switch
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available for Swaps',
                            style: AppTheme.body1.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Make this skill available for skill swaps',
                            style: AppTheme.body2,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isAvailable,
                      onChanged: (value) {
                        setState(() {
                          _isAvailable = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              Consumer<SkillProvider>(
                builder: (context, skillProvider, child) {
                  return ElevatedButton(
                    onPressed: skillProvider.isLoading ? null : _addSkill,
                    style: AppTheme.primaryButtonStyle.copyWith(
                      minimumSize: const WidgetStatePropertyAll(
                        Size(double.infinity, 56),
                      ),
                    ),
                    child: skillProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Add Skill',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 