import 'package:flutter/material.dart';

import '../theme/app_theme.dart';


class SuwaniBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SuwaniBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      indicatorColor: AppTheme.blue.withValues(alpha: 0.12),
      destinations: const [
  NavigationDestination(
    icon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.people_alt_rounded),
    label: 'Elders',
  ),
  NavigationDestination(
    icon: Icon(Icons.notifications_rounded),
    label: 'Alerts',
  ),
  NavigationDestination(
    icon: Icon(Icons.checklist_rounded),
    label: 'Routine',
  ),
],
    );
  }
}