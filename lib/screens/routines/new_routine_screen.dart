
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class NewRoutineScreen extends StatefulWidget {
  const NewRoutineScreen({super.key});

  @override
  State<NewRoutineScreen> createState() => _NewRoutineScreenState();
}

class _NewRoutineScreenState extends State<NewRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _elderController = TextEditingController(
    text: 'Arthur Pendelton',
  );
  final _notesController = TextEditingController();

  String _type = 'Medication';
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 30);
  String _frequency = 'Daily';
  bool _advanceReminder = true;

  final List<Map<String, dynamic>> _types = [
    {
      'name': 'Medication',
      'icon': Icons.medication_rounded,
      'color': const Color(0xFFDAE9FF),
      'iconColor': AppTheme.blue,
    },
    {
      'name': 'Meal',
      'icon': Icons.restaurant_rounded,
      'color': const Color(0xFFFFE9D8),
      'iconColor': const Color(0xFFDB8A36),
    },
    {
      'name': 'Hydration',
      'icon': Icons.water_drop_rounded,
      'color': const Color(0xFFECE3FF),
      'iconColor': const Color(0xFF8156CF),
    },
    {
      'name': 'Exercise',
      'icon': Icons.directions_walk_rounded,
      'color': const Color(0xFFDDF6E9),
      'iconColor': AppTheme.green,
    },
    {
      'name': 'Appointment',
      'icon': Icons.calendar_month_rounded,
      'color': const Color(0xFFFFE2E8),
      'iconColor': const Color(0xFFD84D70),
    },
    {
      'name': 'Custom',
      'icon': Icons.notifications_active_outlined,
      'color': const Color(0xFFE8EDF5),
      'iconColor': AppTheme.navy,
    },
  ];

  @override
  void dispose() {
    _elderController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (selected != null && mounted) {
      setState(() => _time = selected);
    }
  }

  String get _formattedTime {
    final hour = _time.hourOfPeriod == 0 ? 12 : _time.hourOfPeriod;
    final minute = _time.minute.toString().padLeft(2, '0');
    final period = _time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  IconData get _selectedIcon {
    final match = _types.firstWhere(
      (item) => item['name'] == _type,
    );
    return match['icon'] as IconData;
  }

  Color get _selectedColor {
    final match = _types.firstWhere(
      (item) => item['name'] == _type,
    );
    return match['color'] as Color;
  }

  Color get _selectedIconColor {
    final match = _types.firstWhere(
      (item) => item['name'] == _type,
    );
    return match['iconColor'] as Color;
  }

  void _saveRoutine() {
    if (!_formKey.currentState!.validate()) return;

    final title = _notesController.text.trim().isEmpty
        ? _defaultTitle()
        : _defaultTitle();

    Navigator.pop<Map<String, dynamic>>(context, {
      'title': title,
      'time': _formattedTime,
      'frequency': _frequency,
      'type': _type,
      'active': true,
      'advanceReminder': _advanceReminder,
      'notes': _notesController.text.trim(),
      'elderName': _elderController.text.trim(),
      'icon': _selectedIcon,
      'color': _selectedColor,
      'iconColor': _selectedIconColor,
    });
  }

  String _defaultTitle() {
    switch (_type) {
      case 'Medication':
        return 'Medication Reminder';
      case 'Meal':
        return 'Meal Reminder';
      case 'Hydration':
        return 'Hydration Reminder';
      case 'Exercise':
        return 'Exercise Reminder';
      case 'Appointment':
        return 'Appointment Reminder';
      default:
        return 'Custom Routine';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'New Routine',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            const Text(
              'Schedule care alerts & alarms',
              style: TextStyle(color: AppTheme.muted, fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Routine Type',
              style: TextStyle(
                color: AppTheme.navy,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _types.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final item = _types[index];
                final selected = _type == item['name'];
                final iconColor = item['iconColor'] as Color;

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(
                    () => _type = item['name'] as String,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEAF2FF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? AppTheme.blue
                            : const Color(0xFFE5EAF1),
                        width: selected ? 1.8 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: item['color'] as Color,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: iconColor,
                            size: 23,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          item['name'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: selected
                                ? AppTheme.blue
                                : AppTheme.navy,
                          ),
                        ),
                        if (selected)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 14,
                              color: AppTheme.blue,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            const Text(
              'Assign to Elder',
              style: TextStyle(
                color: AppTheme.navy,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _elderController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the elder’s name';
                }
                return null;
              },
              decoration: _inputDecoration(
                hint: 'Elder name',
                icon: Icons.person_outline_rounded,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Time & Frequency',
              style: TextStyle(
                color: AppTheme.navy,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _selectTime,
                    borderRadius: BorderRadius.circular(14),
                    child: InputDecorator(
                      decoration: _inputDecoration(
                        hint: 'Time',
                        icon: Icons.access_time_rounded,
                      ),
                      child: Text(
                        _formattedTime,
                        style: const TextStyle(
                          color: AppTheme.navy,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _frequency,
                    isExpanded: true,
                    decoration: _inputDecoration(
                      hint: 'Frequency',
                      icon: Icons.repeat_rounded,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: 'Every 2 hours',
                        child: Text('Every 2 hours'),
                      ),
                      DropdownMenuItem(
                        value: 'Weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: 'Mon, Wed, Fri',
                        child: Text('Mon, Wed, Fri'),
                      ),
                      DropdownMenuItem(
                        value: 'Once',
                        child: Text('Once'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _frequency = value);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7EBF2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECE3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: Color(0xFF8156CF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advance Reminder Alert',
                          style: TextStyle(
                            color: AppTheme.navy,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Notify 15 minutes before due time',
                          style: TextStyle(
                            color: AppTheme.muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: _advanceReminder,
                    activeTrackColor: AppTheme.blue,
                    onChanged: (value) {
                      setState(() => _advanceReminder = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Notes / Special Instructions',
              style: TextStyle(
                color: AppTheme.navy,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: _inputDecoration(
                hint:
                    'e.g. To be taken with water and half glass of apple juice.',
              ),
            ),
            const SizedBox(height: 26),

            FilledButton.icon(
              onPressed: _saveRoutine,
              icon: const Icon(Icons.check_rounded),
              label: const Text(
                'Save Routine',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon, size: 20),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE3E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE3E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.blue, width: 1.5),
      ),
    );
  }
}
