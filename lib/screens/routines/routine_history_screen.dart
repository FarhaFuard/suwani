
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';

class RoutineHistoryScreen extends StatefulWidget {
  const RoutineHistoryScreen({super.key});

  @override
  State<RoutineHistoryScreen> createState() =>
      _RoutineHistoryScreenState();
}

class _RoutineHistoryScreenState extends State<RoutineHistoryScreen> {
  int _selectedDate = 26;
  bool _weeklyView = false;
  String _elderName = 'Arthur Pendelton';
  String _elderAge = '82 years';

  static const Color _background = Color(0xFFF5F7FB);
  static const Color _border = Color(0xFFE7EBF2);
  static const Color _green = Color(0xFF15966A);
  static const Color _amber = Color(0xFFD49A16);
  static const Color _red = Color(0xFFE45D65);

  final List<_RoutineEntry> _routines = const [
    _RoutineEntry(
      time: '09:30 AM',
      title: 'Morning Donepezil',
      category: 'Medication',
      status: 'Completed',
      icon: Icons.medication_outlined,
    ),
    _RoutineEntry(
      time: '11:00 AM',
      title: 'Hydration Intake (250ml)',
      category: 'Hydration',
      status: 'Pending',
      icon: Icons.water_drop_outlined,
    ),
    _RoutineEntry(
      time: '01:00 PM',
      title: 'Lunch Routine',
      category: 'Meals',
      status: 'Completed',
      icon: Icons.restaurant_outlined,
    ),
    _RoutineEntry(
      time: '04:30 PM',
      title: 'Afternoon Walk',
      category: 'Exercise',
      status: 'Missed',
      icon: Icons.directions_walk_rounded,
    ),
  ];

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
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFE8F0FF),
        child: Icon(Icons.person, color: AppTheme.blue),
      ),
      title: Text(name),
      subtitle: Text(age),
      onTap: () {
        setState(() {
          _elderName = name;
          _elderAge = age;
        });
        Navigator.pop(dialogContext);
      },
    );
  }

  void _showRoutineDetails(_RoutineEntry routine) {
    Color statusColor = _statusColor(routine.status);

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routine.title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
            const SizedBox(height: 14),
            _detailRow(Icons.access_time, 'Scheduled time', routine.time),
            _detailRow(Icons.category_outlined, 'Category', routine.category),
            _detailRow(
              Icons.check_circle_outline,
              'Status',
              routine.status,
              color: statusColor,
            ),
            const SizedBox(height: 18),
            const Text(
              'Demonstration record. Changes to routine status are not '
              'connected to a live care database.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: AppTheme.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String label,
    String value, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? AppTheme.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppTheme.muted, fontSize: 13),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color ?? AppTheme.navy,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return _green;
      case 'Pending':
        return _amber;
      default:
        return _red;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle_rounded;
      case 'Pending':
        return Icons.schedule_rounded;
      default:
        return Icons.cancel_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int completed = _selectedDate == 26 ? 12 : 0;
    final int total = _selectedDate == 26 ? 16 : 0;
    final double rate = total == 0 ? 0 : completed / total;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 22),
                  _buildElderCard(),
                  const SizedBox(height: 22),
                  _buildViewToggle(),
                  const SizedBox(height: 18),
                  if (!_weeklyView) ...[
                    _buildDateStrip(),
                    const SizedBox(height: 22),
                    _buildCompletionCard(rate, completed, total),
                    const SizedBox(height: 26),
                    _buildSectionTitle('Activity Timeline'),
                    const SizedBox(height: 13),
                    ..._routines.map(_buildRoutineCard),
                  ] else ...[
                    _buildWeeklyOverview(),
                  ],
                  const SizedBox(height: 26),
                  _buildSectionTitle('Weekly Adherence Summary'),
                  const SizedBox(height: 13),
                  _buildWeeklyStats(),
                  const SizedBox(height: 16),
                  const Text(
                    'Sample monitoring data for demonstration only.',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SuwaniBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          color: AppTheme.navy,
        ),
        const SizedBox(width: 3),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Routine History',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Monitor care compliance records',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildElderCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFE8F0FF),
            child: Icon(
              Icons.person_rounded,
              size: 30,
              color: AppTheme.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _elderName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 5),
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
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _toggleOption('Daily View', false),
          _toggleOption('Weekly Summary', true),
        ],
      ),
    );
  }

  Widget _toggleOption(String title, bool weekly) {
    final bool selected = _weeklyView == weekly;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _weeklyView = weekly),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected ? AppTheme.blue : AppTheme.muted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateStrip() {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (index) {
          final date = 21 + index;
          final selected = _selectedDate == date;

          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: Container(
              width: 43,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: selected ? AppTheme.blue : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: selected ? AppTheme.blue : _border,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    days[index],
                    style: TextStyle(
                      fontSize: 10,
                      color: selected ? Colors.white : AppTheme.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$date',
                    style: TextStyle(
                      fontSize: 15,
                      color: selected ? Colors.white : AppTheme.navy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? Colors.white
                          : (index == 1 || index == 3 || index == 5
                              ? _green
                              : const Color(0xFFD5DBE5)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCompletionCard(
    double rate,
    int completed,
    int total,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'COMPLETION RATE',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 10,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$completed of $total Done',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${(rate * 100).round()}% Adherence today',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: rate,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE8EDF7),
                    valueColor: const AlwaysStoppedAnimation(AppTheme.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 22),
          SizedBox(
            width: 76,
            height: 76,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: rate,
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFFE8EDF7),
                    valueColor: const AlwaysStoppedAnimation(AppTheme.blue),
                  ),
                ),
                Text(
                  '${(rate * 100).round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: AppTheme.navy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.navy,
        fontSize: 19,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildRoutineCard(_RoutineEntry routine) {
    final color = _statusColor(routine.status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72,
            child: Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text(
                routine.time,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.muted,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(17),
              onTap: () => _showRoutineDetails(routine),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        routine.icon,
                        color: color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            routine.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.navy,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            routine.category,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      _statusIcon(routine.status),
                      color: color,
                      size: 23,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverview() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Summary',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Weekly sample adherence rate',
            style: TextStyle(fontSize: 12, color: AppTheme.muted),
          ),
          const SizedBox(height: 18),
          ...List.generate(7, (index) {
            final dayRate = [0.80, 0.90, 0.75, 0.88, 0.69, 0.75, 0.82][index];
            final day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.muted,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: dayRate,
                        minHeight: 9,
                        backgroundColor: const Color(0xFFE8EDF7),
                        valueColor: const AlwaysStoppedAnimation(AppTheme.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 38,
                    child: Text(
                      '${(dayRate * 100).round()}%',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.navy,
                      ),
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

  Widget _buildWeeklyStats() {
    return Row(
      children: [
        Expanded(
          child: _statCard('88%', 'Avg Rate', const Color(0xFFE8F1FF),
              AppTheme.blue),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _statCard('54', 'Completed', const Color(0xFFE5F7EF),
              _green),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _statCard('3', 'Missed', const Color(0xFFFFE9E9), _red),
        ),
      ],
    );
  }

  Widget _statCard(
    String value,
    String label,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: foreground,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: foreground,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _border),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}

class _RoutineEntry {
  final String time;
  final String title;
  final String category;
  final String status;
  final IconData icon;

  const _RoutineEntry({
    required this.time,
    required this.title,
    required this.category,
    required this.status,
    required this.icon,
  });
}
