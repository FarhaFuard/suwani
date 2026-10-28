import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFEAF0FF),
              child: Icon(
                Icons.person_rounded,
                size: 55,
                color: AppTheme.blue,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'Clara Johnson',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Center(
            child: Text(
              'Caregiver',
              style: TextStyle(color: AppTheme.muted),
            ),
          ),
          const SizedBox(height: 30),
          _profileOption(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () => _showMessage(context, 'Profile editing is not ready yet.'),
          ),
          _profileOption(
            icon: Icons.notifications_outlined,
            title: 'Notification Settings',
            onTap: () => _showMessage(context, 'Notification settings will be added later.'),
          ),
          _profileOption(
            icon: Icons.lock_outline,
            title: 'Privacy and Security',
            onTap: () => _showMessage(context, 'Security settings will be added later.'),
          ),
          _profileOption(
            icon: Icons.help_outline,
            title: 'Help and Support',
            onTap: () => _showMessage(context, 'Help and support will be added later.'),
          ),
          _profileOption(
            icon: Icons.info_outline,
            title: 'About SUWANI',
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'SUWANI',
              applicationVersion: '1.0.0',
              applicationLegalese: 'Care support application demo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE8ECF3)),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.blue),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.navy,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppTheme.muted,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}