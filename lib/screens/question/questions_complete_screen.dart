import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/custom_text_style.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';
import 'package:flutter_study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:flutter_study_app/controllers/question_paper/quiz_controller.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:flutter_study_app/screens/question/questions_screen.dart';
import 'package:flutter_study_app/widgets/app_app_bar.dart';
import 'package:flutter_study_app/widgets/background_decoration_widget.dart';
import 'package:flutter_study_app/widgets/content_area_widget.dart';
import 'package:flutter_study_app/widgets/main_button_widget.dart';
import 'package:flutter_study_app/widgets/question_number_card_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuestionsCompleteScreen extends GetView<QuizController> {
  const QuestionsCompleteScreen({super.key});

  static const String routeName = "/questions_complete";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppAppBar(
        titleWidget: Text(
          controller.completedQuestion,
          style: appBarText,
        ),
      ),
      body: BackgroundDecorationWidget(
        child: Column(
          children: [
            Expanded(
              child: ContentAreaWidget(
                addPadding: true,
                child: Obx(() {
                  return controller.loadingStatus.value ==
                          FirebaseLoadingStatus.loading
                      ? Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/bulb.svg",
                                  width: 120.0,
                                  height: 120.0,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Text("Computing results"),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.hourglass_top_sharp,
                                  color: UiParameters.isDarkMode()
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color
                                      : Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Obx(
                                  () => Text(
                                    "${controller.time.value}  Remaining",
                                    style: appBarText.copyWith(
                                      fontSize: 12.0,
                                      color: UiParameters.isDarkMode()
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.submitted.value,
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/bulb.svg",
                                      width: 120.0,
                                      height: 120.0,
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Obx(
                                      () => controller.correctAnswerCount < 1
                                          ? Text(
                                              "Oh.. Please try again",
                                              style: headerText.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            )
                                          : Text(
                                              "Congratulations",
                                              style: headerText.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Obx(
                                      () => Text(
                                        "You have got ${controller.points} points",
                                        style: detailText.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Tap below to see correct answers.",
                                      style: detailText.copyWith(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GetBuilder<QuizController>(
                              builder: ((controller) {
                                return Expanded(
                                  child: GridView.builder(
                                    itemCount: controller.allQuestions.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: Get.width ~/ 75.0,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemBuilder: (_, index) {
                                      return Obx(
                                        () => QuestionNumberCardWidget(
                                          index: index,
                                          onTap: () {
                                            controller.goToQuestion(index);
                                            Get.toNamed(
                                                QuestionsScreen.routeName);
                                          },
                                          status: controller.getStatus(index),
                                          submitted: controller.submitted.value,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => Visibility(
                                    visible: controller.submitted.value,
                                    child: SizedBox(
                                      width: 55.0,
                                      height: 55.0,
                                      child: MainButtonWidget(
                                        onTap: () {
                                          controller.goToOverview();
                                        },
                                        right: Transform.translate(
                                          offset: const Offset(
                                            0.0,
                                            0.0,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              QuestionPaperController
                                                  questionPaperController =
                                                  Get.find();
                                              questionPaperController
                                                  .navigateToQuestions(
                                                paper: questionPaperController
                                                    .selectedQuestion,
                                                tryAgain: true,
                                              );
                                            },
                                            child: Icon(
                                              Icons.sync,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 55.0,
                                    child: MainButtonWidget(
                                      onTap: () {
                                        controller.submitted.value
                                            ? controller.showLeaderboards()
                                            : controller.submit();
                                      },
                                      left: Obx(() => Text(
                                            controller.submitted.value
                                                ? "Leaderbords"
                                                : "Submit",
                                            style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? onSurfaceTextColor
                                                  : Theme.of(context)
                                                      .primaryColor,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Obx(
                                  () => controller.submitted.value
                                      ? SizedBox(
                                          width: 55.0,
                                          height: 55.0,
                                          child: MainButtonWidget(
                                            onTap: () {
                                              Get.offAllNamed("/home");
                                            },
                                            right: Transform.translate(
                                              offset: const Offset(
                                                0.0,
                                                0.0,
                                              ),
                                              child: Icon(
                                                Icons.home,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mobileScreenPadding,
                            ),
                          ],
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
