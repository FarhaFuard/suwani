
import 'package:flutter/material.dart';

class DigitalHumanAvatar extends StatefulWidget {
  const DigitalHumanAvatar({super.key});

  @override
  State<DigitalHumanAvatar> createState() =>
      _DigitalHumanAvatarState();
}

class _DigitalHumanAvatarState extends State<DigitalHumanAvatar> {
  String selectedArea = 'Overall';

  final Map<String, String> careInfo = {
    'Head': 'Cognitive wellbeing',
    'Chest': 'Heart and breathing',
    'Arms': 'Mobility and movement',
    'Legs': 'Walking and balance',
    'Overall': 'General wellbeing',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Soft background glow
              Container(
                width: 270,
                height: 270,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF10B981).withValues(alpha: 0.18),
                      const Color(0xFF10B981).withValues(alpha: 0.02),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Decorative orbit
              Container(
                width: 245,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(
                    color: const Color(0xFF10B981)
                        .withValues(alpha: 0.18),
                  ),
                ),
              ),

              // Ground shadow
              Positioned(
                bottom: 16,
                child: Container(
                  width: 120,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981)
                            .withValues(alpha: 0.15),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),

              // Human avatar
              Positioned(
                bottom: 22,
                child: SizedBox(
                  width: 190,
                  height: 300,
                  child: CustomPaint(
                    painter: _HumanAvatarPainter(
                      selectedArea: selectedArea,
                    ),
                  ),
                ),
              ),

              // Interactive body markers
              _buildMarker(
                label: 'Head',
                icon: Icons.psychology_rounded,
                top: 32,
                right: 35,
                color: const Color(0xFF8B5CF6),
              ),
              _buildMarker(
                label: 'Chest',
                icon: Icons.favorite_rounded,
                top: 145,
                right: 8,
                color: const Color(0xFFEF6474),
              ),
              _buildMarker(
                label: 'Arms',
                icon: Icons.accessibility_new_rounded,
                top: 190,
                left: 5,
                color: const Color(0xFF0EA5E9),
              ),
              _buildMarker(
                label: 'Legs',
                icon: Icons.directions_walk_rounded,
                bottom: 42,
                right: 22,
                color: const Color(0xFF10B981),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Selected body area information
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.health_and_safety_rounded,
                color: Color(0xFF059669),
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedArea == 'Overall'
                          ? 'Digital Human Overview'
                          : '$selectedArea Care',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D2342),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      careInfo[selectedArea]!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.touch_app_rounded,
                color: Color(0xFF059669),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Tap a marker to explore care areas',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMarker({
    required String label,
    required IconData icon,
    required Color color,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    final bool isSelected = selectedArea == label;

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Tooltip(
        message: label,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              setState(() {
                selectedArea = label;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 52 : 44,
              height: isSelected ? 52 : 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: Colors.white,
                  width: isSelected ? 3 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: isSelected ? 18 : 10,
                    spreadRadius: isSelected ? 2 : 0,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isSelected ? 25 : 21,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HumanAvatarPainter extends CustomPainter {
  final String selectedArea;

  _HumanAvatarPainter({required this.selectedArea});

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 190;
    final double scaleY = size.height / 300;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Shared paint helper
    Paint paint(Color color, {bool shadow = false}) {
      return Paint()
        ..color = color
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..maskFilter = shadow
            ? const MaskFilter.blur(BlurStyle.normal, 5)
            : null;
    }

    final skin = const Color(0xFFE7B995);
    final skinLight = const Color(0xFFF5D2B4);
    final shirt = const Color(0xFF0D9488);
    final shirtLight = const Color(0xFF5EEAD4);
    final trousers = const Color(0xFF243B63);

    // Legs
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(54, 183, 36, 91),
        const Radius.circular(16),
      ),
      paint(trousers),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(100, 183, 36, 91),
        const Radius.circular(16),
      ),
      paint(const Color(0xFF314D78)),
    );

    // Trouser highlights
    canvas.drawLine(
      const Offset(72, 200),
      const Offset(72, 260),
      paint(const Color(0xFF536D95)..withValues(alpha: 0.6))
        ..strokeWidth = 2,
    );

    // Shoes
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(43, 264, 49, 19),
        const Radius.circular(10),
      ),
      paint(const Color(0xFFF8FAFC), shadow: true),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(99, 264, 49, 19),
        const Radius.circular(10),
      ),
      paint(const Color(0xFFE2E8F0), shadow: true),
    );

    // Arms behind the shirt
    canvas.save();
    canvas.translate(48, 105);
    canvas.rotate(-0.12);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-13, 0, 26, 99),
        const Radius.circular(14),
      ),
      paint(skin, shadow: true),
    );
    canvas.restore();

    canvas.save();
    canvas.translate(141, 105);
    canvas.rotate(0.12);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-13, 0, 26, 99),
        const Radius.circular(14),
      ),
      paint(skin, shadow: true),
    );
    canvas.restore();

    // Neck
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(78, 75, 34, 38),
        const Radius.circular(12),
      ),
      paint(skin),
    );

    // Shirt silhouette
    final shirtPath = Path()
      ..moveTo(68, 93)
      ..quadraticBezierTo(95, 81, 122, 93)
      ..lineTo(145, 115)
      ..lineTo(130, 133)
      ..lineTo(123, 124)
      ..lineTo(129, 190)
      ..quadraticBezierTo(95, 202, 61, 190)
      ..lineTo(67, 124)
      ..lineTo(59, 133)
      ..lineTo(44, 115)
      ..close();

    canvas.drawShadow(
      shirtPath,
      Colors.black.withValues(alpha: 0.2),
      8,
      true,
    );

    canvas.drawPath(
      shirtPath,
      paint(shirt),
    );

    // Shirt lighting
    final highlightPath = Path()
      ..moveTo(68, 96)
      ..quadraticBezierTo(78, 92, 88, 94)
      ..lineTo(84, 190)
      ..lineTo(65, 190)
      ..close();

    canvas.drawPath(
      highlightPath,
      paint(shirtLight.withValues(alpha: 0.35)),
    );

    // Collar
    final collar = Path()
      ..moveTo(78, 91)
      ..lineTo(95, 106)
      ..lineTo(85, 117)
      ..lineTo(73, 96)
      ..close();

    canvas.drawPath(collar, paint(const Color(0xFFECFEFF)));

    final collarRight = Path()
      ..moveTo(112, 91)
      ..lineTo(95, 106)
      ..lineTo(105, 117)
      ..lineTo(117, 96)
      ..close();

    canvas.drawPath(
      collarRight,
      paint(const Color(0xFFCCFBF1)),
    );

    // Shirt buttons
    for (final y in [125.0, 141.0, 157.0]) {
      canvas.drawCircle(
        Offset(95, y),
        2,
        paint(const Color(0xFFECFEFF)),
      );
    }

    // Head shadow
    canvas.drawOval(
      const Rect.fromLTWH(61, 13, 69, 82),
      paint(const Color(0xFFB7A49A), shadow: true),
    );

    // Ears
    canvas.drawOval(
      const Rect.fromLTWH(57, 43, 15, 23),
      paint(skin),
    );
    canvas.drawOval(
      const Rect.fromLTWH(119, 43, 15, 23),
      paint(skin),
    );

    // Face
    canvas.drawOval(
      const Rect.fromLTWH(64, 8, 63, 83),
      paint(skinLight, shadow: true),
    );

    // Face shading
    canvas.drawOval(
      const Rect.fromLTWH(99, 18, 24, 63),
      paint(skin.withValues(alpha: 0.45)),
    );

    // Hair
    final hairPath = Path()
      ..moveTo(64, 46)
      ..quadraticBezierTo(54, 17, 77, 7)
      ..quadraticBezierTo(104, -3, 126, 17)
      ..quadraticBezierTo(135, 30, 126, 49)
      ..lineTo(118, 31)
      ..quadraticBezierTo(92, 17, 73, 33)
      ..lineTo(64, 46)
      ..close();

    canvas.drawPath(
      hairPath,
      paint(const Color(0xFFCBD5E1)),
    );

    // Hair shadows
    canvas.drawArc(
      const Rect.fromLTWH(70, 7, 50, 27),
      3.3,
      2.7,
      false,
      paint(const Color(0xFF94A3B8))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Eyebrows
    canvas.drawLine(
      const Offset(76, 42),
      const Offset(87, 40),
      paint(const Color(0xFF64748B))
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawLine(
      const Offset(103, 40),
      const Offset(114, 42),
      paint(const Color(0xFF64748B))
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );

    // Eyes
    canvas.drawOval(
      const Rect.fromLTWH(77, 46, 8, 5),
      paint(Colors.white),
    );
    canvas.drawOval(
      const Rect.fromLTWH(104, 46, 8, 5),
      paint(Colors.white),
    );
    canvas.drawCircle(
      const Offset(81, 48),
      2,
      paint(const Color(0xFF334155)),
    );
    canvas.drawCircle(
      const Offset(108, 48),
      2,
      paint(const Color(0xFF334155)),
    );

    // Nose
    final nose = Path()
      ..moveTo(94, 47)
      ..lineTo(89, 61)
      ..quadraticBezierTo(95, 65, 100, 61);

    canvas.drawPath(
      nose,
      paint(const Color(0xFFC18B70))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );

    // Smile
    canvas.drawArc(
      const Rect.fromLTWH(82, 62, 27, 15),
      0.2,
      2.7,
      false,
      paint(const Color(0xFF9A5B50))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );

    // Subtle age lines
    for (final x in [75.0, 108.0]) {
      canvas.drawLine(
        Offset(x, 56),
        Offset(x + 5, 57),
        paint(const Color(0xFFC18B70).withValues(alpha: 0.6))
          ..strokeWidth = 1,
      );
    }

    // Selected area glow
    if (selectedArea == 'Head') {
      canvas.drawOval(
        const Rect.fromLTWH(60, 4, 70, 90),
        paint(const Color(0xFF8B5CF6).withValues(alpha: 0.12)),
      );
    } else if (selectedArea == 'Chest') {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(65, 110, 60, 65),
          const Radius.circular(20),
        ),
        paint(const Color(0xFFEF6474).withValues(alpha: 0.18)),
      );
    } else if (selectedArea == 'Arms') {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(38, 100, 115, 85),
          const Radius.circular(30),
        ),
        paint(const Color(0xFF0EA5E9).withValues(alpha: 0.10)),
      );
    } else if (selectedArea == 'Legs') {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(48, 183, 90, 88),
          const Radius.circular(20),
        ),
        paint(const Color(0xFF10B981).withValues(alpha: 0.18)),
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HumanAvatarPainter oldDelegate) {
    return oldDelegate.selectedArea != selectedArea;
  }
}
