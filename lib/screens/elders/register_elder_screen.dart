
import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_theme.dart';

class RegisterElderScreen extends StatefulWidget {
  const RegisterElderScreen({super.key});

  @override
  State<RegisterElderScreen> createState() => _RegisterElderScreenState();
}

class _RegisterElderScreenState extends State<RegisterElderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _medicalController = TextEditingController();
  final _contactController = TextEditingController();
  final _relationshipController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _photo;
  bool _isSubmitting = false;
  final bool _voiceEnrolled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _medicalController.dispose();
    _contactController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1000,
      );

      if (image != null && mounted) {
        setState(() => _photo = image);
      }
    } catch (_) {
      if (mounted) {
        _message('Unable to select a photo. Please try again.');
      }
    }
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 70),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Select date of birth',
    );

    if (selected != null) {
      setState(() {
        _dobController.text =
            '${selected.month.toString().padLeft(2, '0')}/'
            '${selected.day.toString().padLeft(2, '0')}/'
            '${selected.year}';
      });
    }
  }

  void _showVoiceEnrollmentInfo() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.mic_none_rounded,
          color: Color(0xFF8057C8),
          size: 34,
        ),
        title: const Text('Voice Enrollment'),
        content: const Text(
          'Voice recording and AI voice analysis are not connected yet. '
          'No voice sample will be recorded or uploaded at this stage.',
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

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month &&
            today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<void> _registerElder() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final parts = _dobController.text.split('/');
      final birthDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      final name = _nameController.text.trim();
      final age = _calculateAge(birthDate);

      // Return the new elder to the Elders screen.
      // Permanent database storage will be added later.
      final elder = <String, dynamic>{
        'name': name,
        'age': age,
        'status': 'Stable',
        'activity': 'Profile registered just now',
        'initials': name
            .split(RegExp(r'\s+'))
            .where((part) => part.isNotEmpty)
            .take(2)
            .map((part) => part[0].toUpperCase())
            .join(),
        'avatarColor': const Color(0xFFDCE9FF),
        'statusColor': AppTheme.green,
        'dateOfBirth': _dobController.text,
        'medicalConditions': _medicalController.text.trim(),
        'emergencyContact': _contactController.text.trim(),
        'relationship': _relationshipController.text.trim(),
        'photoPath': _photo?.path,
        'voiceEnrolled': _voiceEnrolled,
      };

      if (!mounted) return;
      Navigator.pop(context, elder);
    } catch (_) {
      _message('Unable to register this profile. Check the date of birth.');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration _fieldDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppTheme.muted,
        fontSize: 13,
      ),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.coral),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.navy,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(label),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: _fieldDecoration(hint, suffixIcon: suffixIcon),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Go back',
        ),
        title: const Text(
          'Register New Elder',
          style: TextStyle(
            color: AppTheme.navy,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 24),
            children: [
              const Text(
                'Register a new profile under your care',
                style: TextStyle(
                  color: AppTheme.muted,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 22),

              // Profile photo upload
              InkWell(
                onTap: _pickPhoto,
                borderRadius: BorderRadius.circular(17),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: const Color(0xFFE3E8F0)),
                  ),
                  child: Row(
                    children: [
                      if (_photo == null)
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF0FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: AppTheme.blue,
                            size: 25,
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SizedBox(
                            width: 54,
                            height: 54,
                            child: kIsWeb
                                ? Image.network(
                                    _photo!.path,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(_photo!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload Profile Photo',
                              style: TextStyle(
                                color: AppTheme.navy,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Recommended: clear passport-style portrait',
                              style: TextStyle(
                                color: AppTheme.muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppTheme.muted,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 23),

              _textField(
                label: 'Full Name *',
                hint: 'e.g. Arthur Pendelton',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the elder’s full name.';
                  }
                  if (value.trim().length < 2) {
                    return 'Please enter a valid name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              _textField(
                label: 'Date of Birth *',
                hint: 'MM/DD/YYYY',
                controller: _dobController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the date of birth.';
                  }

                  final parts = value.split('/');
                  if (parts.length != 3) {
                    return 'Please select a valid date.';
                  }

                  try {
                    final date = DateTime(
                      int.parse(parts[2]),
                      int.parse(parts[0]),
                      int.parse(parts[1]),
                    );

                    if (date.month != int.parse(parts[0]) ||
                        date.day != int.parse(parts[1]) ||
                        date.year != int.parse(parts[2]) ||
                        date.isAfter(DateTime.now())) {
                      return 'Please enter a valid past date.';
                    }
                  } catch (_) {
                    return 'Please select a valid date.';
                  }

                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: _selectDate,
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: AppTheme.blue,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              _textField(
                label: 'Medical Conditions',
                hint: "Alzheimer's disease, High blood pressure, Arthritis",
                controller: _medicalController,
                maxLines: 3,
              ),
              const SizedBox(height: 18),

              // Contact details side by side on wider screens
              LayoutBuilder(
                builder: (context, constraints) {
                  final contact = _textField(
                    label: 'Emergency Contact *',
                    hint: '+1 (555) 019-2831',
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a contact number.';
                      }
                      if (value.trim().length < 7) {
                        return 'Enter a valid number.';
                      }
                      return null;
                    },
                  );

                  final relationship = _textField(
                    label: 'Relationship *',
                    hint: 'e.g. Daughter',
                    controller: _relationshipController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter relationship.';
                      }
                      return null;
                    },
                  );

                  if (constraints.maxWidth < 430) {
                    return Column(
                      children: [
                        contact,
                        const SizedBox(height: 18),
                        relationship,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: contact),
                      const SizedBox(width: 12),
                      Expanded(child: relationship),
                    ],
                  );
                },
              ),
              const SizedBox(height: 23),

              // Voice enrollment
              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F0FF),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: const Color(0xFFDDD0FA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.mic_none_rounded,
                          color: Color(0xFF8057C8),
                        ),
                        SizedBox(width: 9),
                        Text(
                          'Voice Enrollment',
                          style: TextStyle(
                            color: AppTheme.navy,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Allows AI routines to detect vocal patterns, distress '
                      'levels and call responses.',
                      style: TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _showVoiceEnrollmentInfo,
                        icon: const Icon(Icons.mic_rounded),
                        label: const Text('Record Voice Sample'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF8057C8),
                          side: const BorderSide(
                            color: Color(0xFF8057C8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Voice recording will be enabled when the voice service '
                      'is connected.',
                      style: TextStyle(
                        color: Color(0xFF705A91),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Submit
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _registerElder,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 21,
                          width: 21,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Register Elder',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
