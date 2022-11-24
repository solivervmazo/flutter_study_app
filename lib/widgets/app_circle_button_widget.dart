import 'package:flutter/material.dart';

class AppCircleButtonWidget extends StatelessWidget {
  const AppCircleButtonWidget({
    super.key,
    required this.child,
    this.color,
    this.width = 60.0,
    this.onTap,
    this.circle = false,
  });
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: circle ? const CircleBorder() : null,
      color: color,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
