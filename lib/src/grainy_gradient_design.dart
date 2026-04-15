import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

class GrainyGradientDesign {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFFF06292), 
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.transparent, 
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white.withOpacity(0.1),
        indicatorColor: Colors.white.withOpacity(0.3),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
        iconTheme: WidgetStateProperty.all(
          const IconThemeData(color: Colors.white),
        ),
      ),
    );
  }
}

class GrainBackground extends StatelessWidget {
  final Widget child;

  const GrainBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFE8C97), // Soft pink
            Color(0xFFE54E6D), // Vibrant red-pink
            Color(0xFFFA9E74), // Peachy
            Color(0xFFE53457), // Deep red/pink
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background soft shapes imitating organic gradient flows
          Positioned(top: -100, left: -50, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFFA6B1).withOpacity(0.5)))),
          Positioned(bottom: -50, right: -100, child: Container(width: 400, height: 400, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFF7A8F).withOpacity(0.6)))),
          
          // Sparkle elements
          Positioned(top: 80, right: 60, child: const _Sparkle(size: 90, color: Colors.white)),
          Positioned(top: 240, right: 10, child: const _Sparkle(size: 45, color: Color(0xFFC2183D))),
          Positioned(bottom: 220, left: 30, child: const _Sparkle(size: 80, color: Color(0xFFC2183D))),
          
          // Grain Overlay Layer
          CustomPaint(
            painter: _GrainPainter(),
          ),
          
          // Actual content inside the background
          child,
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  final double size;
  final Color color;

  const _Sparkle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SparklePainter(color: color),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Color color;

  _SparklePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final w = size.width;
    
    // Four pointer star drawing
    path.moveTo(center.dx, 0);
    path.quadraticBezierTo(center.dx, center.dy - w * 0.1, center.dx + w / 2, center.dy);
    path.quadraticBezierTo(center.dx, center.dy + w * 0.1, center.dx, w);
    path.quadraticBezierTo(center.dx, center.dy + w * 0.1, center.dx - w / 2, center.dy);
    path.quadraticBezierTo(center.dx, center.dy - w * 0.1, center.dx, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Random random = Random(42); 
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.04)
      ..strokeWidth = 1.0;
      
    final int pointsCount = (size.width * size.height * 0.25).toInt().clamp(0, 50000); 
    
    final points = <Offset>[];
    for(int i = 0; i < pointsCount; i++) {
       points.add(Offset(random.nextDouble() * size.width, random.nextDouble() * size.height));
    }
    
    canvas.drawPoints(ui.PointMode.points, points, paint);

    // Some extra white points to give dynamic noise profile
    final paintWhite = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..strokeWidth = 1.0;
    
    final pointsW = <Offset>[];
    for(int i = 0; i < pointsCount ~/ 2; i++) {
       pointsW.add(Offset(random.nextDouble() * size.width, random.nextDouble() * size.height));
    }
    
    canvas.drawPoints(ui.PointMode.points, pointsW, paintWhite);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
