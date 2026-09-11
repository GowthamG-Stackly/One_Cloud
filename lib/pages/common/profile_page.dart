import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: AppTheme.primaryBlue,
                            child: Text(
                              userProvider.name.isNotEmpty
                                  ? userProvider.name[0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Text(
                            userProvider.name.isNotEmpty
                                ? userProvider.name
                                : 'User',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            userProvider.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),

                          const SizedBox(height: 30),

                          const Divider(),

                          const SizedBox(height: 20),

                          _profileRow(
                            Icons.person_outline,
                            'Name',
                            userProvider.name,
                          ),

                          const SizedBox(height: 20),

                          _profileRow(
                            Icons.email_outlined,
                            'Email',
                            userProvider.email,
                          ),

                          const SizedBox(height: 20),

                          _profileRow(
                            Icons.verified_user_outlined,
                            'Account Status',
                            userProvider.isLoggedIn
                                ? 'Logged In'
                                : 'Not Logged In',
                          ),

                          const SizedBox(height: 20),

                          _profileRow(
                            Icons.security,
                            'Authentication',
                            '2-Step Verification',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 24),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 4),

              Text(
                value.isNotEmpty ? value : 'Not available',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
