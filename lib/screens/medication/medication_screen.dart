import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/medication_card.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medication Schedule',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Today’s Medications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Review the scheduled medication reminders for each elder.',
            style: TextStyle(
              color: AppTheme.muted,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 22),
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
          const MedicationCard(
            medicine: 'Vitamin D',
            dosage: '1000 IU',
            elderName: 'Robert Wilson',
            time: '12:00 PM',
          ),
          const MedicationCard(
            medicine: 'Calcium',
            dosage: '500 mg',
            elderName: 'Eleanor James',
            time: '06:00 PM',
          ),
          const SizedBox(height: 12),
          const Text(
            'Demo data only. Confirm medication names, doses, and schedules '
            'with the appropriate healthcare professional before real-world use.',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}