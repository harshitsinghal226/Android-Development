import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;
          
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header
                Container(
                  decoration: AppTheme.cardDecoration,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        child: user.profileImage != null
                            ? ClipOval(
                                child: Image.network(
                                  user.profileImage!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppTheme.primaryColor,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 50,
                                color: AppTheme.primaryColor,
                              ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: AppTheme.heading2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style: AppTheme.body2,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            'Rating',
                            user.rating.toString(),
                            Icons.star,
                            AppTheme.warningColor,
                          ),
                          _buildStatItem(
                            'Swaps',
                            user.completedSwaps.toString(),
                            Icons.swap_horiz,
                            AppTheme.primaryColor,
                          ),
                          _buildStatItem(
                            'Skills',
                            user.skills.length.toString(),
                            Icons.psychology,
                            AppTheme.successColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Bio Section
                if (user.bio != null && user.bio!.isNotEmpty) ...[
                  Container(
                    decoration: AppTheme.cardDecoration,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About',
                          style: AppTheme.heading3,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.bio!,
                          style: AppTheme.body1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Skills Section
                Container(
                  decoration: AppTheme.cardDecoration,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'My Skills',
                            style: AppTheme.heading3,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // TODO: Navigate to edit skills
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (user.skills.isEmpty)
                        Text(
                          'No skills added yet',
                          style: AppTheme.body2.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: user.skills.map((skill) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.primaryColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                skill,
                                style: AppTheme.body2.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Interests Section
                Container(
                  decoration: AppTheme.cardDecoration,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Interests',
                            style: AppTheme.heading3,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // TODO: Navigate to edit interests
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (user.interests.isEmpty)
                        Text(
                          'No interests added yet',
                          style: AppTheme.body2.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: user.interests.map((interest) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.accentColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                interest,
                                style: AppTheme.body2.copyWith(
                                  color: AppTheme.accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to edit profile
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: AppTheme.outlineButtonStyle.copyWith(
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 48),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await authProvider.logout();
                          if (context.mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: AppTheme.outlineButtonStyle.copyWith(
                          minimumSize: const WidgetStatePropertyAll(
                            Size(double.infinity, 48),
                          ),
                          foregroundColor: WidgetStateProperty.all(AppTheme.errorColor),
                          side: WidgetStateProperty.all(
                            BorderSide(color: AppTheme.errorColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.heading3.copyWith(
            color: color,
          ),
        ),
        Text(
          label,
          style: AppTheme.caption,
        ),
      ],
    );
  }
} 