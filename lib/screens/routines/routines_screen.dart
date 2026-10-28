
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'new_routine_screen.dart';

class RoutinesScreen extends StatefulWidget {
  const RoutinesScreen({super.key});

  @override
  State<RoutinesScreen> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  String _filter = 'All';

  final List<Map<String, dynamic>> _routines = [
    {
      'title': 'Morning Donepezil',
      'time': '09:30 AM',
      'frequency': 'Daily',
      'type': 'Medication',
      'active': true,
      'icon': Icons.medication_rounded,
      'color': const Color(0xFFDAE9FF),
      'iconColor': AppTheme.blue,
    },
    {
      'title': 'Hydration Reminder',
      'time': '11:00 AM',
      'frequency': 'Every 2 hours',
      'type': 'Hydration',
      'active': true,
      'icon': Icons.water_drop_rounded,
      'color': const Color(0xFFECE3FF),
      'iconColor': const Color(0xFF8156CF),
    },
    {
      'title': 'Afternoon Walk',
      'time': '04:30 PM',
      'frequency': 'Mon, Wed, Fri',
      'type': 'Exercise',
      'active': false,
      'icon': Icons.monitor_heart_rounded,
      'color': const Color(0xFFDDF6E9),
      'iconColor': AppTheme.green,
    },
  ];

  final List<String> _filters = [
    'All',
    'Medication',
    'Meals',
    'Hydration',
    'Exercise',
  ];

  List<Map<String, dynamic>> get _visibleRoutines {
    if (_filter == 'All') return _routines;
    return _routines.where((routine) {
      return routine['type'] == _filter ||
          (_filter == 'Meals' && routine['type'] == 'Meal');
    }).toList();
  }

  Future<void> _createRoutine() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => const NewRoutineScreen(),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      _routines.add(result);
      _filter = 'All';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${result['title']} added successfully.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routines = _visibleRoutines;

    return Scaffold(
      backgroundColor: AppTheme.pageBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          "Arthur's Routines",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createRoutine,
        backgroundColor: const Color(0xFF7951C8),
        foregroundColor: Colors.white,
        tooltip: 'Add routine',
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 18),
            child: Text(
              'Manage schedules and alarms',
              style: TextStyle(color: AppTheme.muted, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final label = _filters[index];
                final selected = _filter == label;

                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _filter = label),
                  backgroundColor: Colors.white,
                  selectedColor: AppTheme.blue,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppTheme.muted,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  side: BorderSide(
                    color: selected
                        ? AppTheme.blue
                        : const Color(0xFFE3E8F0),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Scheduled routines',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.navy,
                    ),
                  ),
                ),
                Text(
                  '${routines.length} routines',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.muted,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: routines.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event_note_rounded,
                            size: 48,
                            color: AppTheme.muted,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No routines in this category',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.navy,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tap + to create a routine.',
                            style: TextStyle(color: AppTheme.muted),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
                    itemCount: routines.length,
                    itemBuilder: (context, index) {
                      final routine = routines[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 13),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFE9EDF4),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: routine['color'] as Color? ??
                                    const Color(0xFFDAE9FF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                routine['icon'] as IconData? ??
                                    Icons.event_note_rounded,
                                color: routine['iconColor'] as Color? ??
                                    AppTheme.blue,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    routine['title']?.toString() ??
                                        'New routine',
                                    style: const TextStyle(
                                      color: AppTheme.navy,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    '${routine['time']} • ${routine['frequency']}',
                                    style: const TextStyle(
                                      color: AppTheme.muted,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    routine['type']?.toString() ?? 'Custom',
                                    style: const TextStyle(
                                      color: AppTheme.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch.adaptive(
                              value: routine['active'] == true,
                              activeTrackColor: AppTheme.blue,
                              onChanged: (value) {
                                setState(() {
                                  routine['active'] = value;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(
                                      value
                                          ? 'Routine enabled.'
                                          : 'Routine disabled.',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
