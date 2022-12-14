import 'package:flutter/cupertino.dart';
import 'package:flutter_study_app/controllers/app_zoom_controller.dart';
import 'package:flutter_study_app/controllers/question_paper/data_uploader.dart';
import 'package:flutter_study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/controllers/question_paper/quiz_controller.dart';
import 'package:flutter_study_app/screens/home/home_screen.dart';
import 'package:flutter_study_app/screens/introduction/introduction_screen.dart';
import 'package:flutter_study_app/screens/question/questions_complete_screen.dart';
import 'package:flutter_study_app/screens/question/questions_screen.dart';
import 'package:flutter_study_app/screens/signin_screen.dart';
import 'package:flutter_study_app/screens/splash/splash_screen.dart';
import 'package:flutter_study_app/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SafeArea(
            child: SplashScreen(),
          ),
        ),
        GetPage(
          name: "/introduction",
          page: () => const IntroductionScreen(),
        ),
        GetPage(
          name: "/home",
          page: () => const SafeArea(
            child: HomeScreen(),
          ),
          binding: BindingsBuilder(
            () {
              // Get.put(DataUploader());
              Get.put(FirebaseStorageService());
              Get.put(QuestionPaperController());
              Get.put(AppZoomController());
            },
          ),
        ),
        GetPage(
          name: "/signin",
          page: () => const SafeArea(
            child: SigninScreen(),
          ),
        ),
        GetPage(
          name: "/${QuestionsScreen.routeName}",
          page: () => const SafeArea(
            child: QuestionsScreen(),
          ),
          binding: BindingsBuilder(() {
            Get.put<QuizController>(QuizController());
          }),
        ),
        GetPage(
          name: "/${QuestionsCompleteScreen.routeName}",
          page: () => const SafeArea(
            child: QuestionsCompleteScreen(),
          ),
          binding: BindingsBuilder(() {
            Get.put<QuizController>(
              QuizController(),
            );
            Get.put<QuestionPaperController>(QuestionPaperController());
          }),
        ),
      ];
}
