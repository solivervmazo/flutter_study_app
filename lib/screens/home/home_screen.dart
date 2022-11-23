import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/app_icons.dart';
import 'package:flutter_study_app/config/themes/custom_text_style.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';
import 'package:flutter_study_app/controllers/app_zoom_controller.dart';
import 'package:flutter_study_app/controllers/auth_controller.dart';
import 'package:flutter_study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/screens/home/menu_screen.dart';
import 'package:flutter_study_app/screens/home/question_card_widget.dart';
import 'package:flutter_study_app/widgets/app_circle_button_widget.dart';
import 'package:flutter_study_app/widgets/content_area_widget.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<AppZoomController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    AuthController authController = Get.find();
    return Scaffold(
      body: GetBuilder<AppZoomController>(
        builder: (controller) => Container(
          decoration: BoxDecoration(
            gradient: mainGradient(),
          ),
          child: ZoomDrawer(
            controller: controller.zoomDrawerController,
            borderRadius: 50.0,
            showShadow: false,
            angle: 0.0,
            style: DrawerStyle.defaultStyle,
            slideWidth: MediaQuery.of(context).size.width * 0.7,
            moveMenuScreen: true,
            menuScreen: const MenuScreen(),
            mainScreen: Container(
              decoration: BoxDecoration(
                gradient: mainGradient(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCircleButtonWidget(
                          onTap: controller.toggleDrawer,
                          circle: false,
                          child: const Icon(
                            AppIcons.menuLeft,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              const Icon(
                                AppIcons.peace,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              authController.isLoggedIn()
                                  ? Text(
                                      "Hello ${authController.getUser()!.displayName!}",
                                      style: const TextStyle(
                                        color: onSurfaceTextColor,
                                      ),
                                    )
                                  : Text.rich(
                                      TextSpan(
                                        text: "To get started ",
                                        style: const TextStyle(
                                          color: onSurfaceTextColor,
                                          fontSize: 14.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.toNamed("/signin");
                                              },
                                            text: "Sign in",
                                            style: const TextStyle(
                                              color: onSurfaceTextColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        const Text(
                          "Do you want to learn today?",
                          style: headerText,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: ContentAreaWidget(
                        addPadding: false,
                        child: Obx(
                          () => ListView.separated(
                            padding: UiParameters.mobileScreenPadding,
                            itemBuilder: (context, index) {
                              return QuestionCardWidget(
                                question:
                                    questionPaperController.allPapers[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20.0,
                              );
                            },
                            itemCount: questionPaperController.allPapers.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
