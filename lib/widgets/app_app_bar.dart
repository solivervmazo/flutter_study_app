import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_icons.dart';
import 'package:flutter_study_app/config/themes/custom_text_style.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';
import 'package:flutter_study_app/controllers/question_paper/quiz_controller.dart';
import 'package:get/get.dart';

class AppAppBar extends GetView implements PreferredSize {
  const AppAppBar({
    super.key,
    this.title = "",
    this.showActionIcon = false,
    this.onMenuActionTap,
    this.titleWidget,
    this.leading,
  });

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    Get.put(() => QuizController());
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarText,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Transform.translate(
                      offset: const Offset(
                        -14,
                        0,
                      ),
                      child: const BackButton(),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset: const Offset(
                      10.0,
                      0.0,
                    ),
                    child: GestureDetector(
                      onTap: onMenuActionTap,
                      child: const Icon(
                        AppIcons.menuRight,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80.0,
      );
}
