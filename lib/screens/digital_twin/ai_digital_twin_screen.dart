
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';

class AiDigitalTwinScreen extends StatefulWidget {
  const AiDigitalTwinScreen({super.key});

  @override
  State<AiDigitalTwinScreen> createState() =>
      _AiDigitalTwinScreenState();
}

class _AiDigitalTwinScreenState extends State<AiDigitalTwinScreen> {
  static const Color _background = Color(0xFFF5F7FB);
  static const Color _border = Color(0xFFE8ECF3);
  static const Color _purple = Color(0xFF8B5CF6);
  static const Color _amber = Color(0xFFB7791F);

  int _currentIndex = 0;
  String _elderName = 'Arthur Pendelton';
  String _elderAge = '82 years';

  void _onNavigationTap(int index) {
    if (index == 0) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    // The shared navigation bar can display the other destinations.
    // Replace this with your app's central navigation if needed.
    setState(() => _currentIndex = index);
    _showMessage(
      'Open the ${['Home', 'Elders', 'Alerts', 'Routine'][index]} '
      'screen from your app navigation.',
    );
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
            _elderOption(dialogContext, 'Arthur Pendelton', '82 years'),
            _elderOption(dialogContext, 'Martha Vance', '82 years'),
            _elderOption(dialogContext, 'David Chen', '85 years'),
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
        backgroundColor: AppTheme.blue.withValues(alpha: 0.1),
        child: const Icon(Icons.person_rounded, color: AppTheme.blue),
      ),
      title: Text(name),
      subtitle: Text(age),
      trailing: _elderName == name
          ? const Icon(Icons.check_circle, color: AppTheme.blue)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 22, 18, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 22),
                  _buildSelectedElder(),
                  const SizedBox(height: 22),
                  _buildCognitiveBanner(),
                  const SizedBox(height: 26),
                  _sectionHeading('Behavioral Trends'),
                  const SizedBox(height: 13),
                  _buildSleepCard(),
                  const SizedBox(height: 12),
                  _buildRoutineDeviationCard(),
                  const SizedBox(height: 26),
                  _sectionHeading('Active Anomalies'),
                  const SizedBox(height: 13),
                  _buildAnomalyCard(
                    title: 'Unusual Nighttime Activity',
                    confidence: '94%',
                    description:
                        'Arthur was active between 2:00 AM - 4:00 AM '
                        '(expected sleep). High risk of daytime fatigue.',
                    accent: const Color(0xFF8B5CF6),
                    background: const Color(0xFFF4F0FF),
                  ),
                  const SizedBox(height: 12),
                  _buildAnomalyCard(
                    title: 'Decreased Social Interaction',
                    confidence: '87%',
                    description:
                        'Vocal distress score slightly increased, '
                        'accompanied by 30% fewer verbal interactions today.',
                    accent: const Color(0xFF3983D7),
                    background: const Color(0xFFEDF5FF),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Demonstration data only. These model confidence '
                    'values and anomaly descriptions are not live '
                    'clinical predictions or a medical diagnosis.',
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.5,
                      color: AppTheme.muted,
                    ),
                  ),
                ],
              ),
            ),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI & Digital Twin',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: AppTheme.navy,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Predictive models and cognitive trends',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.muted,
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
            radius: 26,
            backgroundColor: const Color(0xFFE7F0FF),
            child: const Icon(
              Icons.person_rounded,
              size: 32,
              color: AppTheme.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SELECTED ELDER',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _elderName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _elderAge,
                  style: const TextStyle(
                    fontSize: 12,
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

  Widget _buildCognitiveBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2868D7),
            Color(0xFF6945C4),
            Color(0xFF8454D6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5E50C7).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 9,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.psychology_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'COGNITIVE TWIN v.2.4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '98.4% Model Confidence',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Dynamic Status:',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFDCE7FF),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Stable Care',
            style: TextStyle(
              fontSize: 27,
              height: 1.2,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'No immediate physical emergency predicted. '
            'Minor cognitive fluctuations logged.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Color(0xFFE9E9FF),
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Predictive insights overview',
                  style: TextStyle(
                    color: Colors.white,
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
  }

  Widget _sectionHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppTheme.navy,
      ),
    );
  }

  Widget _buildSleepCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFF1EAFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.nights_stay_rounded,
              color: _purple,
              size: 24,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sleep Quality Trend',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Average 7.2 hrs',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 74,
            height: 54,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sleepBar(25),
                _sleepBar(35),
                _sleepBar(29),
                _sleepBar(45),
                _sleepBar(38),
                _sleepBar(49),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sleepBar(double height) {
    return Container(
      width: 7,
      height: height,
      decoration: BoxDecoration(
        color: _purple.withValues(
          alpha: height > 40 ? 1 : 0.55,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildRoutineDeviationCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3D9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.directions_walk_rounded,
              color: _amber,
              size: 24,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Routine Deviations (48h)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Likely to skip afternoon walk',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2D6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Adherence Risk',
                    style: TextStyle(
                      color: Color(0xFF946200),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '82%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _amber,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Prob.',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnomalyCard({
    required String title,
    required String confidence,
    required String description,
    required Color accent,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 39,
                height: 39,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.psychology_alt_rounded,
                  color: accent,
                  size: 23,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.navy,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  confidence,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              height: 1.65,
              color: AppTheme.muted,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: accent,
                size: 15,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Review this observation with the caregiver.',
                  style: TextStyle(
                    fontSize: 11,
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: _border),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF152B4D).withValues(alpha: 0.025),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
