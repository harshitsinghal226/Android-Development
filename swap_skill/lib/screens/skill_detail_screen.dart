import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/skill.dart';
import '../providers/auth_provider.dart';
import '../utils/theme.dart';

class SkillDetailScreen extends StatelessWidget {
  final Skill skill;

  const SkillDetailScreen({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthProvider>().currentUser;
    final isOwnSkill = currentUser?.id == skill.userId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Details'),
        actions: [
          if (!isOwnSkill)
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // TODO: Add to favorites
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skill Images (placeholder)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Icon(
                Icons.psychology,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        child: skill.userProfileImage != null
                            ? ClipOval(
                                child: Image.network(
                                  skill.userProfileImage!,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      color: AppTheme.primaryColor,
                                      size: 24,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skill.userName,
                              style: AppTheme.heading3,
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(skill.category).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          skill.category,
                          style: AppTheme.body2.copyWith(
                            color: _getCategoryColor(skill.category),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Skill Title and Description
                  Text(
                    skill.title,
                    style: AppTheme.heading1,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    skill.description,
                    style: AppTheme.body1,
                  ),
                  const SizedBox(height: 24),

                  // Skill Details
                  Container(
                    decoration: AppTheme.cardDecoration,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildDetailRow('Difficulty', skill.difficulty, Icons.trending_up),
                        const Divider(),
                        _buildDetailRow('Estimated Time', '${skill.estimatedHours} hours', Icons.access_time),
                        const Divider(),
                        _buildDetailRow('Location', skill.location, Icons.location_on),
                        const Divider(),
                        _buildDetailRow('Available', skill.isAvailable ? 'Yes' : 'No', Icons.check_circle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tags
                  if (skill.tags.isNotEmpty) ...[
                    Text(
                      'Tags',
                      style: AppTheme.heading3,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: skill.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.borderColor),
                          ),
                          child: Text(
                            tag,
                            style: AppTheme.body2,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Action Buttons
                  if (!isOwnSkill) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showSwapDialog(context);
                        },
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text('Request Swap'),
                        style: AppTheme.primaryButtonStyle.copyWith(
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 56),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to chat
                        },
                        icon: const Icon(Icons.message),
                        label: const Text('Message User'),
                        style: AppTheme.outlineButtonStyle.copyWith(
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 56),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Edit skill
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Skill'),
                        style: AppTheme.outlineButtonStyle.copyWith(
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 56),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.textSecondaryColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.caption,
              ),
              Text(
                value,
                style: AppTheme.body1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
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

  void _showSwapDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Skill Swap'),
        content: const Text(
          'Are you sure you want to request a swap for this skill? You\'ll need to offer a skill in return.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to swap request screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Swap request sent!'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Request Swap'),
          ),
        ],
      ),
    );
  }
} 