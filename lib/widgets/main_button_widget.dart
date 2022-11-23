import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.onTap,
    this.left,
    this.right,
  });

  final VoidCallback onTap;
  final Widget? left;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            left ?? const SizedBox(),
            if (left != null && right != null)
              const SizedBox(
                width: 20.0,
              ),
            right ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
