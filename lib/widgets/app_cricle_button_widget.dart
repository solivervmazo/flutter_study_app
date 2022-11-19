import 'package:flutter/material.dart';

class AppCricleButtonWidget extends StatelessWidget {
  const AppCricleButtonWidget({
    super.key,
    required this.child,
    this.color,
    this.width = 60.0,
    this.onTap,
  });
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      color: color,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
