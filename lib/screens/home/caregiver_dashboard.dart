import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/digital_human_avatar.dart';
import '../../widgets/medication_card.dart';
import '../../widgets/quick_action_button.dart';
import '../alerts/alerts_screen.dart';
import '../digital_twin/ai_digital_twin_screen.dart';
import '../elders/elders_screen.dart';
import '../medication/medication_screen.dart';
import '../routines/routine_history_screen.dart';
import '../emergency/emergency_sos_screen.dart';

class CaregiverDashboard extends StatefulWidget {
  const CaregiverDashboard({super.key});

  @override
  State<CaregiverDashboard> createState() =>
      _CaregiverDashboardState();
}

class _CaregiverDashboardState extends State<CaregiverDashboard> {
  int _currentIndex = 0;

  String _elderName = 'Arthur Pendelton';
  String _elderAge = '82 years';

  static const Color _background = Color(0xFFF5F7FB);
  static const Color _border = Color(0xFFE7ECF3);
  static const Color _purple = Color(0xFF8B5CF6);
  static const Color _green = Color(0xFF16A36A);
  static const Color _red = Color(0xFFEF6B70);

  final List<Widget> _screens = const [
    SizedBox.shrink(),
    EldersScreen(),
    AlertsScreen(),
    RoutineHistoryScreen(),
  ];

  void _onNavigationTap(int index) {
    if (index < 0 || index >= _screens.length) return;

    setState(() {
      _currentIndex = index;
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _changeElder() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select an elder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _elderOption(
              dialogContext,
              'Arthur Pendelton',
              '82 years',
            ),
            _elderOption(
              dialogContext,
              'Martha Vance',
              '82 years',
            ),
            _elderOption(
              dialogContext,
              'David Chen',
              '85 years',
            ),
          ],
        ),
      ),
    );
  }

  Widget _elderOption(
    BuildContext dialogContext,
    String name,
    String age,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppTheme.blue.withValues(alpha: 0.10),
        child: const Icon(
          Icons.person_rounded,
          color: AppTheme.blue,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(age),
      trailing: _elderName == name
          ? const Icon(
              Icons.check_circle,
              color: _green,
            )
          : null,
      onTap: () {
        setState(() {
          _elderName = name;
          _elderAge = age;
        });

        Navigator.pop(dialogContext);
        _showMessage('$name selected.');
      },
    );
  }

  void _showCallInfo() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.call_outlined,
          color: _red,
          size: 32,
        ),
        title: const Text('Start Call'),
        content: Text(
          'Calling $_elderName is not connected yet. '
          'Connect a calling service to enable real calls.',
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

  void _showSosConfirmation() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.sos_rounded,
          color: _red,
          size: 34,
        ),
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

  void _showTwinAssistant() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SUWANI Twin Assistant',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore the sample care insights and suggested '
                'actions. This assistant is not connected to a '
                'live AI service.',
                style: TextStyle(color: AppTheme.muted),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _openDigitalTwinDetails();
                  },
                  icon: const Icon(Icons.insights_rounded),
                  label: const Text('Review twin details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDigitalTwinDetails() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const AiDigitalTwinScreen(),
      ),
    );
  }

  void _openMedicationSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const MedicationScreen(),
      ),
    );
  }

  void _openRoutineHistory() {
    _onNavigationTap(3);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 0) {
  return Scaffold(
    backgroundColor: _background,
    body: _screens[_currentIndex],
    bottomNavigationBar: _currentIndex == 3
        ? null
        : SuwaniBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onNavigationTap,
          ),
  );
}

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 32 : 18,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1180,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 22),
                      _buildSelectedElder(),
                      const SizedBox(height: 22),
                      _buildTwinCard(isWide: isWide),
                      const SizedBox(height: 18),
                      _buildRoutineSummary(),
                      const SizedBox(height: 22),
                      _buildMedicationSection(),
                      const SizedBox(height: 22),
                      _buildQuickActions(),
                      const SizedBox(height: 18),
                      const Text(
                        'Illustrative information only · '
                        'Not a medical diagnosis',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTwinAssistant,
        backgroundColor: AppTheme.blue,
        foregroundColor: Colors.white,
        tooltip: 'Open Twin Assistant',
        child: const Icon(Icons.auto_awesome_rounded),
      ),
      bottomNavigationBar: SuwaniBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Digital Twin',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                  letterSpacing: -0.6,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Care insights at a glance',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.muted,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.blue.withValues(alpha: 0.25),
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 23,
            backgroundColor: AppTheme.blue.withValues(alpha: 0.10),
            child: const Icon(
              Icons.person_rounded,
              color: AppTheme.blue,
              size: 29,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedElder() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundColor: Color(0xFFE5F0FF),
            child: Icon(
              Icons.person_rounded,
              size: 33,
              color: AppTheme.blue,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SELECTED ELDER',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _elderName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _elderAge,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.muted,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _changeElder,
            child: const Text(
              'Change',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwinCard({required bool isWide}) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF152B4D)
                .withValues(alpha: 0.035),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _elderName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.navy,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Illustrative digital twin · based on routines, '
                      'activity, and caregiver notes',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: AppTheme.muted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F7ED),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: _green,
                      size: 8,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Demo',
                      style: TextStyle(
                        color: Color(0xFF147D50),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildPredictionPanel()),
                const SizedBox(width: 15),
                Expanded(child: _buildHumanGraphic()),
                const SizedBox(width: 15),
                Expanded(child: _buildSuggestionsPanel()),
              ],
            )
          else ...[
            _buildPredictionPanel(),
            const SizedBox(height: 20),
            _buildHumanGraphic(),
            const SizedBox(height: 20),
            _buildSuggestionsPanel(),
          ],
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _openDigitalTwinDetails,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFE9E8),
                foregroundColor: const Color(0xFFC94F55),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'More Details',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Care indicators',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppTheme.navy,
          ),
        ),
        const SizedBox(height: 19),
        _predictionItem('Hydration', 0.72, AppTheme.blue),
        _predictionItem('Mobility', 0.58, _purple),
        _predictionItem('Social', 0.84, AppTheme.blue),
        _predictionItem('Medication', 0.41, _red),
      ],
    );
  }

  Widget _predictionItem(
    String label,
    double value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: const Color(0xFFEDF0F6),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHumanGraphic() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FAF4),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD9F0E2),
        ),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.blur_on_rounded,
                size: 16,
                color: Color(0xFF398663),
              ),
              SizedBox(width: 7),
              Flexible(
                child: Text(
                  'INTERACTIVE DIGITAL HUMAN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    color: Color(0xFF398663),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const DigitalHumanAvatar(),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFFD9F0E2),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 15,
                  color: Color(0xFF398663),
                ),
                SizedBox(width: 6),
                Text(
                  'Explore care areas',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF398663),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Care suggestions',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppTheme.navy,
          ),
        ),
        const SizedBox(height: 16),
        _suggestionCard(
          Icons.water_drop_rounded,
          'Offer water before 10 AM',
          const Color(0xFFE8F3FF),
          AppTheme.blue,
        ),
        const SizedBox(height: 11),
        _suggestionCard(
          Icons.directions_walk_rounded,
          'Short walk after lunch',
          const Color(0xFFE8F8EF),
          _green,
        ),
        const SizedBox(height: 11),
        _suggestionCard(
          Icons.medication_rounded,
          'Confirm medication at 9:30 AM',
          const Color(0xFFFFEEEE),
          _red,
        ),
      ],
    );
  }

  Widget _suggestionCard(
    IconData icon,
    String text,
    Color background,
    Color foreground,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: foreground, size: 19),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                height: 1.45,
                fontWeight: FontWeight.w600,
                color: AppTheme.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Today's Routines",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
              ),
              Text(
                '68% done',
                style: TextStyle(
                  color: AppTheme.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
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
          const SizedBox(height: 12),
          const Text(
            '12 of 18 completed. Sample dashboard data.',
            style: TextStyle(
              color: AppTheme.muted,
              fontSize: 13,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _openRoutineHistory,
              child: const Text('View routine history'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              onPressed: _openMedicationSchedule,
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
        const SizedBox(height: 6),
        const Text(
          'Sample reminders only. Verify medication details '
          'against the elder’s actual prescription.',
          style: TextStyle(
            fontSize: 11,
            color: AppTheme.muted,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            Expanded(
              child: QuickActionButton(
                icon: Icons.person_add_alt_1_rounded,
                label: 'Add Elder',
                color: AppTheme.blue,
                onTap: () {
                  _onNavigationTap(1);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickActionButton(
                icon: Icons.call_outlined,
                label: 'Start Call',
                color: _green,
                onTap: _showCallInfo,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickActionButton(
                icon: Icons.sos_rounded,
                label: 'SOS Emergency',
                color: _red,
                onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => const EmergencySosScreen(),
        ),
      );
    },
  ),
),
        
          ],
        ),
      ],
    );
  }
}