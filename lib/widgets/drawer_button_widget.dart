import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';

class DrawerButtonWidget extends StatelessWidget {
  const DrawerButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor: onSurfaceTextColor,
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 15,
          color: onSurfaceTextColor,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: onSurfaceTextColor,
          ),
        ),
      ),
    );
  }
}
