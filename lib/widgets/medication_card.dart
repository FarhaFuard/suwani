import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MedicationCard extends StatelessWidget {
  final String medicine;
  final String dosage;
  final String elderName;
  final String time;
  final VoidCallback? onTap;

  const MedicationCard({
    super.key,
    required this.medicine,
    required this.dosage,
    required this.elderName,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF3)),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: AppTheme.blue,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dosage,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  elderName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.navy,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 17,
                color: AppTheme.blue,
              ),
              const SizedBox(height: 5),
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: AppTheme.navy,
                ),
              ),
            ],
          ),
          if (onTap != null)
            IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.chevron_right_rounded),
              color: AppTheme.muted,
            ),
        ],
      ),
    );
  }
}