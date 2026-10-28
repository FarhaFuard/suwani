
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../routines/routine_history_screen.dart';
import '../calls/voice_call_screen.dart';

class ElderProfileScreen extends StatelessWidget {
  const ElderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Arthur Pendelton',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          const Text(
            'Detailed patient file',
            style: TextStyle(color: AppTheme.muted),
          ),
          const SizedBox(height: 20),

          // Patient information
          _card(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: const Color(0xFFDCE9FF),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 48,
                    color: AppTheme.blue,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'PATIENT ID #SU-84920',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 11,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Arthur Pendelton',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                const SizedBox(height: 12),
                _statusBadge('STABLE CARE', AppTheme.green),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Digital Twin card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF49318A), Color(0xFF8060CE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.psychology_rounded,
                        color: Colors.white, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Digital Twin Model',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.auto_awesome, color: Colors.white70),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'AI: 98.4% CONFIDENCE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(color: Colors.white24),
                const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF72F0B4), size: 10),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Live Monitored',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      'Last analysis: 2m ago',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Demo values — connect your ML service for real analysis.',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle('Personal Details'),
          const SizedBox(height: 10),
          _card(
            child: const Column(
              children: [
                _DetailRow(
                  icon: Icons.cake_outlined,
                  title: 'Age / Blood Type',
                  value: '78 Years old • O Positive',
                ),
                Divider(height: 24),
                _DetailRow(
                  icon: Icons.medical_information_outlined,
                  title: 'Medical Conditions',
                  value: "Alzheimer's (Stage 1), Mild Hypertension",
                ),
                Divider(height: 24),
                _DetailRow(
                  icon: Icons.phone_outlined,
                  title: 'Emergency Contact',
                  value: '+1 (555) 019-2831',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle('Today’s Routine Progress', trailing: '80% Done'),
          const SizedBox(height: 12),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 10,
                    backgroundColor: Color(0xFFE6ECF5),
                    valueColor: AlwaysStoppedAnimation(AppTheme.blue),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '4 of 5 routines completed',
                  style: TextStyle(color: AppTheme.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle('Recent Activity'),
          const SizedBox(height: 10),
          _activityCard(
            color: AppTheme.green,
            icon: Icons.favorite_outline_rounded,
            title: 'Heart Rate Normal',
            subtitle:
                'Stable 72 BPM analyzed via Digital Twin • 10m ago',
          ),
          const SizedBox(height: 10),
          _activityCard(
            color: AppTheme.blue,
            icon: Icons.medication_outlined,
            title: 'Medication Logged',
            subtitle: 'Donepezil (Aricept) administered • 9:30 AM',
          ),
          const SizedBox(height: 24),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile editing will be available here.'),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.navy,
              minimumSize: const Size.fromHeight(50),
              side: const BorderSide(color: Color(0xFFDCE3ED)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RoutineHistoryScreen(),
                  ),
                  );
                  },
            icon: const Icon(Icons.calendar_month_rounded),
            label: const Text('View Routines'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF7350C5),
              minimumSize: const Size.fromHeight(50),
              side: const BorderSide(color: Color(0xFFB9A5EA)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const VoiceCallScreen(),
    ),
  );
},
            icon: const Icon(Icons.call_rounded),
            label: const Text('Call Elder'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.blue,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EDF4)),
      ),
      child: child,
    );
  }

  static Widget _sectionTitle(String title, {String? trailing}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppTheme.navy,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: const TextStyle(
              color: AppTheme.blue,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  static Widget _statusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _activityCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 23),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 9, color: color),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.blue, size: 21),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.muted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  color: AppTheme.navy,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
