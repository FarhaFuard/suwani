
import 'dart:async';
import 'package:flutter/material.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen>
    with SingleTickerProviderStateMixin {
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  // Starts at 02:34 for this active-call UI demonstration.
  int _callSeconds = 154;
  Timer? _callTimer;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _callSeconds++);
      }
    });
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_callSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_callSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _endCall() {
    _callTimer?.cancel();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF081B45),
              Color(0xFF38216D),
              Color(0xFF6840A5),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 34),

              const Text(
                'SUWANI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 5,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Voice Call',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),

              const Spacer(flex: 2),

              // Glowing and pulsing elder avatar.
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final pulse = _pulseController.value;

                  return Container(
                    padding: EdgeInsets.all(8 + pulse * 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(
                          alpha: 0.16 + pulse * 0.22,
                        ),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFBCA8FF)
                              .withValues(alpha: 0.12 + pulse * 0.20),
                          blurRadius: 20 + pulse * 15,
                          spreadRadius: 2 + pulse * 4,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFF8B78C8),
                        shape: BoxShape.circle,
                      ),
                      child: child,
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 76,
                  backgroundColor: const Color(0xFFDCD4F7),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/elder_avatar.png',
                      width: 152,
                      height: 152,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          width: 152,
                          height: 152,
                          child: Icon(
                            Icons.elderly_rounded,
                            size: 88,
                            color: Color(0xFF57427E),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 34),

              const Text(
                'Margaret Johnson',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5AE6A0),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'Connected $_formattedTime',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.82),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 3),

              // Call controls.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CallControl(
                      icon: _isMuted ? Icons.mic_off : Icons.mic,
                      label: _isMuted ? 'Unmute' : 'Mute',
                      backgroundColor: Colors.white.withValues(alpha: 0.16),
                      onTap: () {
                        setState(() => _isMuted = !_isMuted);
                      },
                    ),

                    _CallControl(
                      icon: Icons.call_end_rounded,
                      label: 'End Call',
                      backgroundColor: const Color(0xFFFF4B59),
                      iconSize: 34,
                      onTap: _endCall,
                    ),

                    _CallControl(
                      icon: _isSpeakerOn
                          ? Icons.volume_up_rounded
                          : Icons.volume_down_rounded,
                      label: 'Speaker',
                      backgroundColor: _isSpeakerOn
                          ? const Color(0xFFB7A5F5)
                          : Colors.white.withValues(alpha: 0.90),
                      iconColor: const Color(0xFF302052),
                      onTap: () {
                        setState(() => _isSpeakerOn = !_isSpeakerOn);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 38),

              // iOS-style home indicator.
              Container(
                width: 135,
                height: 5,
                margin: const EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.90),
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

class _CallControl extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final VoidCallback onTap;

  const _CallControl({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
    this.iconColor = Colors.white,
    this.iconSize = 29,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: Column(
        children: [
          Material(
            color: backgroundColor,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 70,
                height: 70,
                child: Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
