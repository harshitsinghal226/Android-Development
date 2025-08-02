import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/skill_provider.dart';
import '../utils/theme.dart';
import '../widgets/skill_card.dart';
import 'skill_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedDifficulty = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SkillProvider>().loadSkills();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Skills'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: AppTheme.inputDecoration(
                hintText: 'Search for skills, users, or tags...',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filters
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: AppTheme.heading3,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        'Category',
                        _selectedCategory,
                        ['All', 'Programming', 'Design', 'Arts', 'Music', 'Lifestyle'],
                        (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildFilterDropdown(
                        'Difficulty',
                        _selectedDifficulty,
                        ['All', 'Beginner', 'Intermediate', 'Advanced'],
                        (value) {
                          setState(() {
                            _selectedDifficulty = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Results
          Expanded(
            child: Consumer<SkillProvider>(
              builder: (context, skillProvider, child) {
                if (skillProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var filteredSkills = skillProvider.skills;

                // Apply search filter
                if (_searchController.text.isNotEmpty) {
                  filteredSkills = skillProvider.searchSkills(_searchController.text);
                }

                // Apply category filter
                if (_selectedCategory != 'All') {
                  filteredSkills = filteredSkills
                      .where((skill) => skill.category == _selectedCategory)
                      .toList();
                }

                // Apply difficulty filter
                if (_selectedDifficulty != 'All') {
                  filteredSkills = filteredSkills
                      .where((skill) => skill.difficulty == _selectedDifficulty)
                      .toList();
                }

                if (filteredSkills.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppTheme.textSecondaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No skills found',
                          style: AppTheme.body1.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: AppTheme.body2.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    final skill = filteredSkills[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SkillCard(
                        skill: skill,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SkillDetailScreen(skill: skill),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.body2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
            style: AppTheme.body2,
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
} 