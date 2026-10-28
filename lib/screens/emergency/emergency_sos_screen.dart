
import 'package:flutter/material.dart';

class EmergencySosScreen extends StatelessWidget {
  const EmergencySosScreen({super.key});

  static const Color _red = Color(0xFFFF3348);
  static const Color _darkRed = Color(0xFFB90025);

  void _showCallNotice(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Emergency calling'),
        content: const Text(
          'This is a demonstration screen. No emergency services '
          'have been contacted. Connect a verified local emergency '
          'number or responder calling service before using this feature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _cancelAlert(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_red, Color(0xFFE81939), _darkRed],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                  child: Column(
                    children: [
                      // Critical alert banner.
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'CRITICAL ALERT PREPARATION ACTIVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Glowing SOS badge.
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.35),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.sos_rounded,
                          color: _darkRed,
                          size: 55,
                        ),
                      ),

                      const SizedBox(height: 17),

                      // Patient avatar.
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.8),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/elder_avatar.png',
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.elderly_rounded,
                                  size: 44,
                                  color: _darkRed,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      const Text(
                        'Emergency Alert Sent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Patient: Margaret Johnson\n'
                        'Area: Living Room',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Care network notification card.
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.13),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CARE NETWORK NOTIFICATIONS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(height: 17),

                            const _ContactRow(
                              name: 'Sarah Chen, RN',
                              role: 'Caregiver',
                              status: 'NOTIFIED',
                              statusColor: Color(0xFF8BFFD0),
                              icon: Icons.favorite_rounded,
                            ),

                            const _ContactRow(
                              name: 'Dr. Pendelton',
                              role: 'Primary Physician',
                              status: 'CALLING',
                              statusColor: Color(0xFFFFE49B),
                              icon: Icons.medical_services_rounded,
                            ),

                            const _ContactRow(
                              name: '911 Emergency',
                              role: 'First Responders',
                              status: 'DISPATCHING',
                              statusColor: Color(0xFFFFC4C9),
                              icon: Icons.local_hospital_rounded,
                              showDivider: false,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Primary action.
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () => _showCallNotice(context),
                          icon: const Icon(Icons.call_rounded),
                          label: const Text(
                            'Call Now',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: _darkRed,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Cancel / return action.
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () => _cancelAlert(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        'DEMO ONLY • No emergency services contacted.\n'
                        'Live medical data has not been shared.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 10,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // iOS-style home indicator.
              Container(
                width: 135,
                height: 5,
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  final Color statusColor;
  final IconData icon;
  final bool showDivider;

  const _ContactRow({
    required this.name,
    required this.role,
    required this.status,
    required this.statusColor,
    required this.icon,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 21),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.17),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.65),
                  ),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: Colors.white.withValues(alpha: 0.18),
          ),
      ],
    );
  }
}
