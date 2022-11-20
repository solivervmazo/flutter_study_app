import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/widgets/app_circle_button_widget.dart';
import 'package:get/get.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 65.0,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "This is a study app. You can use it as you want, if you understand how it this works. You would be able to scale it",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              AppCircleButtonWidget(
                onTap: () => Get.toNamed("/home"),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 35.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
