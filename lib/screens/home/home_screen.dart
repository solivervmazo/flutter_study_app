import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();

    return Scaffold(
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) {
            return ClipRRect(
              child: SizedBox(
                height: 200.0,
                width: 200.0,
                child: FadeInImage(
                  placeholder:
                      const AssetImage("assets/images/app_splash_logo.png"),
                  image: NetworkImage(
                    questionPaperController.allPaperImages[index],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 20.0,
            );
          },
          itemCount: questionPaperController.allPaperImages.length,
        ),
      ),
    );
  }
}
