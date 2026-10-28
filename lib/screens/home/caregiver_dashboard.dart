
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../alerts/alerts_screen.dart';
import '../elders/elders_screen.dart';
import '../routines/routines_screen.dart';
import '../digital_twin/ai_digital_twin_screen.dart';
import '../../widgets/digital_human_avatar.dart';

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

  final List<Widget> _screens = const [
    SizedBox.shrink(),
    EldersScreen(),
    AlertsScreen(),
    RoutinesScreen(),
  ];

  static const Color _background = Color(0xFFF5F7FB);
  static const Color _border = Color(0xFFE7ECF3);
  static const Color _purple = Color(0xFF8B5CF6);
  static const Color _green = Color(0xFF16A36A);
  static const Color _red = Color(0xFFEF6B70);

  void _onNavigationTap(int index) {
    setState(() => _currentIndex = index);
  }

  void _showMessage(String message) {
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
          ? const Icon(Icons.check_circle, color: _green)
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

  void _showMoreDetails() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Digital Twin Details',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$_elderName · Illustrative overview',
                style: const TextStyle(color: AppTheme.muted),
              ),
              const SizedBox(height: 20),
              _detailRow(
                Icons.water_drop_outlined,
                'Hydration',
                '72%',
                AppTheme.blue,
              ),
              _detailRow(
                Icons.directions_walk_rounded,
                'Mobility',
                '58%',
                _purple,
              ),
              _detailRow(
                Icons.people_outline_rounded,
                'Social activity',
                '84%',
                AppTheme.blue,
              ),
              _detailRow(
                Icons.medication_outlined,
                'Medication',
                '41%',
                _red,
              ),
              const SizedBox(height: 14),
              const Text(
                'Suggested care actions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 10),
              _suggestion(
                Icons.water_drop_rounded,
                'Offer water before 10 AM',
              ),
              _suggestion(
                Icons.directions_walk_rounded,
                'Short walk after lunch',
              ),
              _suggestion(
                Icons.medication_rounded,
                'Confirm meds at 9:30 AM',
              ),
              const SizedBox(height: 12),
              const Text(
                'These values are sample UI data. They are not '
                'generated by a connected AI model or medical device.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggestion(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: _green,
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
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

  void _showTwinAssistant() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
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
                'This demo assistant highlights the sample care '
                'suggestions shown on this screen. It is not a '
                'connected AI service.',
                style: TextStyle(color: AppTheme.muted),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showMoreDetails();
                },
                icon: const Icon(Icons.insights_rounded),
                label: const Text('Review twin details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 0) {
      return Scaffold(
        backgroundColor: _background,
        body: _screens[_currentIndex],
        bottomNavigationBar: SuwaniBottomNavBar(
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
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 22),
                      _buildSelectedElder(),
                      const SizedBox(height: 22),
                      _buildTwinCard(isWide: isWide),
                      const SizedBox(height: 16),
                      _buildCallAction(),
                      const SizedBox(height: 18),
                      const Text(
                        'Illustrative information only · Not a medical diagnosis',
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
        elevation: 4,
        shape: const CircleBorder(),
        tooltip: 'Open Twin Assistant',
        child: const Text(
          'T',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
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
          CircleAvatar(
            radius: 27,
            backgroundColor: const Color(0xFFE5F0FF),
            child: const Icon(
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
            color: const Color(0xFF152B4D).withValues(alpha: 0.035),
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
                      'Illustrative digital twin · based on routine, '
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
                    Icon(Icons.circle, color: _green, size: 8),
                    SizedBox(width: 6),
                    Text(
                      'Stable',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const AiDigitalTwinScreen(),
                    ),
                  );
                },
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
          'Prediction levels',
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
            Text(
              'INTERACTIVE DIGITAL HUMAN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: Color(0xFF398663),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Reusable avatar from lib/widgets/digital_human_avatar.dart
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
          'Suggestions',
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
          'Confirm meds at 9:30 AM',
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

  Widget _buildCallAction() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: _showCallInfo,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _border),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFFFE9E8),
                child: Icon(
                  Icons.call_rounded,
                  color: _red,
                  size: 23,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Call',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.navy,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Connect with your selected elder',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppTheme.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
