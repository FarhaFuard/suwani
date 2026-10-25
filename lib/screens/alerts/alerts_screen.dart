import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      {
        'title': 'Medication reminder',
        'message': 'Martha Vance has a medication scheduled for 10:00 AM.',
        'time': 'Today · 10:00 AM',
        'icon': Icons.medication_outlined,
        'color': AppTheme.coral,
      },
      {
        'title': 'Routine pending',
        'message': 'An activity in today’s routine is still pending.',
        'time': 'Today · 09:45 AM',
        'icon': Icons.checklist_rounded,
        'color': AppTheme.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alerts',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Stay informed about important updates.',
            style: TextStyle(color: AppTheme.muted, fontSize: 14),
          ),
          const SizedBox(height: 20),
          ...alerts.map((alert) {
            final color = alert['color'] as Color;

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE8ECF3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      alert['icon'] as IconData,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert['title'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.navy,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          alert['message'] as String,
                          style: const TextStyle(
                            color: AppTheme.muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          alert['time'] as String,
                          style: const TextStyle(
                            color: AppTheme.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}