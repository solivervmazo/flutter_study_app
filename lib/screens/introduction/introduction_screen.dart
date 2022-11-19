import 'package:flutter/material.dart';
import 'package:flutter_study_app/widgets/app_cricle_button_widget.dart';
import 'package:get/get.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.star,
                size: 65.0,
                color: Colors.amber,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "This is a study app. You can use it as you want, if you understand how it this works. You would be able to scale it",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              AppCricleButtonWidget(
                child: Icon(
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
