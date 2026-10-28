import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/medication_card.dart';
import '../../widgets/quick_action_button.dart';
import '../alerts/alerts_screen.dart';
import '../elders/elders_screen.dart';
import '../profile/profile_screen.dart';
import '../medication/medication_screen.dart';
import '../routines/routines_screen.dart';

class CaregiverDashboard extends StatefulWidget {
  const CaregiverDashboard({super.key});

  @override
  State<CaregiverDashboard> createState() => _CaregiverDashboardState();
}

class _CaregiverDashboardState extends State<CaregiverDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SizedBox.shrink(),
    EldersScreen(),
    AlertsScreen(),
    ProfileScreen(),
  ];

  void _onNavigationTap(int index) {
    if (index == 0) {
      setState(() => _currentIndex = 0);
      return;
    }

    setState(() => _currentIndex = index);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSosConfirmation() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Emergency SOS'),
        content: const Text(
          'This is a demonstration only. No emergency contact '
          'or emergency service will be notified.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _showMessage('Demo only: SOS was not sent.');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 0) {
      return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: SuwaniBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavigationTap,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and caregiver profile
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, Clara',
                          style: TextStyle(
                            color: AppTheme.navy,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Here are your updates for today',
                          style: TextStyle(
                            color: AppTheme.muted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppTheme.blue.withValues(alpha: 0.12),
                    child: const Icon(
                      Icons.person_rounded,
                      color: AppTheme.blue,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Overview
              Row(
                children: [
                  Expanded(
                    child: _overviewCard(
                      title: 'ACTIVE ELDERS',
                      value: '4 Elders',
                      subtitle: 'All actively monitored',
                      icon: Icons.people_alt_outlined,
                      iconColor: AppTheme.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _overviewCard(
                      title: 'ACTIVE ALERTS',
                      value: '2 Urgent',
                      subtitle: 'Requires attention',
                      icon: Icons.notifications_active_outlined,
                      iconColor: AppTheme.coral,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // Today's routines
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Routines",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.navy,
                    ),
                  ),
                  Text(
                    '68% Done',
                    style: TextStyle(
                      color: AppTheme.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE8ECF3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        value: 0.68,
                        minHeight: 9,
                        backgroundColor: Color(0xFFE8EDF7),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Text(
                      '12 of 18 completed. Next routine at 10:00 AM.',
                      style: TextStyle(
                        color: AppTheme.muted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const RoutinesScreen(),
                            ),
                          );
                        },
                        child: const Text('View routines'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Medication heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Medication Reminders',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.navy,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const MedicationScreen(),
                        ),
                      );
                    },
                    child: const Text('View Schedule'),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const MedicationCard(
                medicine: 'Donepezil (Aricept)',
                dosage: '10 mg',
                elderName: 'Arthur Pendelton',
                time: '09:30 AM',
              ),
              const MedicationCard(
                medicine: 'Metformin',
                dosage: '500 mg',
                elderName: 'Martha Vance',
                time: '10:00 AM',
              ),

              const SizedBox(height: 18),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 14),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuickActionButton(
                    icon: Icons.person_add_alt_1_rounded,
                    label: 'Add Elder',
                    color: AppTheme.blue,
                    onTap: () => _showMessage(
                      'Add Elder form will be added next.',
                    ),
                  ),
                  QuickActionButton(
                    icon: Icons.call_outlined,
                    label: 'Start Call',
                    color: AppTheme.green,
                    onTap: () => _showMessage(
                      'Calling is not connected yet.',
                    ),
                  ),
                  QuickActionButton(
                    icon: Icons.sos_rounded,
                    label: 'SOS Emergency',
                    color: AppTheme.coral,
                    onTap: _showSosConfirmation,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SuwaniBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
      ),
    );
  }

  Widget _overviewCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8ECF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 25),
          const SizedBox(height: 13),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.navy,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}