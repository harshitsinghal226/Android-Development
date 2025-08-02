import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/skill.dart';
import '../utils/theme.dart';

class SkillCard extends StatelessWidget {
  final Skill skill;
  final VoidCallback? onTap;

  const SkillCard({
    super.key,
    required this.skill,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppTheme.cardDecoration,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info and rating
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  child: skill.userProfileImage != null
                      ? ClipOval(
                          child: Image.network(
                            skill.userProfileImage!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: AppTheme.primaryColor,
                                size: 20,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.userName,
                        style: AppTheme.body1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: AppTheme.warningColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            skill.userRating.toString(),
                            style: AppTheme.body2,
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppTheme.textSecondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            skill.location,
                            style: AppTheme.body2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(skill.category).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    skill.category,
                    style: AppTheme.caption.copyWith(
                      color: _getCategoryColor(skill.category),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Skill title and description
            Text(
              skill.title,
              style: AppTheme.heading3,
            ),
            const SizedBox(height: 8),
            Text(
              skill.description,
              style: AppTheme.body2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // Tags
            if (skill.tags.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: skill.tags.take(3).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: AppTheme.caption,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],

            // Footer with difficulty, hours, and date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(skill.difficulty).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    skill.difficulty,
                    style: AppTheme.caption.copyWith(
                      color: _getDifficultyColor(skill.difficulty),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppTheme.textSecondaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '${skill.estimatedHours}h',
                  style: AppTheme.caption,
                ),
                const Spacer(),
                Text(
                  DateFormat('MMM dd').format(skill.createdAt),
                  style: AppTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'programming':
        return AppTheme.primaryColor;
      case 'design':
        return AppTheme.secondaryColor;
      case 'arts':
        return AppTheme.accentColor;
      case 'music':
        return AppTheme.successColor;
      case 'lifestyle':
        return AppTheme.warningColor;
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppTheme.successColor;
      case 'intermediate':
        return AppTheme.warningColor;
      case 'advanced':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondaryColor;
    }
  }
} 