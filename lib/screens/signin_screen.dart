import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/controllers/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SigninScreen extends GetView<AuthController> {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
        ),
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/app_splash_logo.png",
                width: 200.0,
                height: 200.0,
              ),
            ),
            // const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await controller.signInWithGoogle();
                      Get.offAllNamed("/home");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/google.svg"),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const Text(
                          "Signin with Google",
                        ),
                      ],
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
}
