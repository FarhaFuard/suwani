import 'package:flutter/material.dart';

import 'screens/home/caregiver_dashboard.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SuwaniApp());
}

class SuwaniApp extends StatelessWidget {
  const SuwaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUWANI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const CaregiverDashboard(),
    );
  }
}