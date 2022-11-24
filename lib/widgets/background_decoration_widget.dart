import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';

class BackgroundDecorationWidget extends StatelessWidget {
  const BackgroundDecorationWidget({
    super.key,
    required this.child,
    this.showGradient = true,
  });

  final Widget child;
  final bool showGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            // width: Get.width,
            // height: Get.height,
            decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient() : null,
            ),
            // child: CustomPaint(
            //   painter: BackGroundPainter(),
            // ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: child,
          ),
        ),
      ],
    );
  }
}

class BackGroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width * 0.2, 0.0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    final path1 = Path();
    path1.moveTo(size.width * 0.6, 0.0);
    path1.lineTo(size.width, 0.0);
    path1.lineTo(size.width, size.height);
    path1.lineTo(size.width * 0.12, size.height);
    path1.close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
