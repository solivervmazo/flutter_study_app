import 'package:flutter/cupertino.dart';
import 'package:flutter_study_app/controllers/app_zoom_controller.dart';
import 'package:flutter_study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/screens/home/home_screen.dart';
import 'package:flutter_study_app/screens/introduction/introduction_screen.dart';
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
              Get.put(FirebaseStorageService());
              Get.put(QuestionPaperController());
              Get.put(AppZoomController());
            },
          ),
        ),
        GetPage(
          name: "/signin",
          page: () => const SigninScreen(),
        ),
      ];
}
