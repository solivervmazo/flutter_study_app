import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/app_icons.dart';
import 'package:flutter_study_app/config/themes/custom_text_style.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';
import 'package:flutter_study_app/controllers/question_paper/quiz_controller.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:flutter_study_app/widgets/answer_card_widget.dart';
import 'package:flutter_study_app/widgets/app_app_bar.dart';
import 'package:flutter_study_app/widgets/background_decoration_widget.dart';
import 'package:flutter_study_app/widgets/content_area_widget.dart';
import 'package:flutter_study_app/widgets/main_button_widget.dart';
import 'package:flutter_study_app/widgets/question_placeholder_widget.dart';
import 'package:get/get.dart';

class QuestionsScreen extends GetView<QuizController> {
  static const String routeName = "question_screen";

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: onSurfaceTextColor,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.hourglass_top_sharp,
              ),
              Obx(
                () => Text(
                  controller.time.value,
                  style: appBarText.copyWith(fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
        titleWidget: Obx(
          () => Text(
            "${controller.questionIdex.value + 1} of ${controller.allQuestions.length} questions",
            style: appBarText,
          ),
        ),
      ),
      body: BackgroundDecorationWidget(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value ==
                  FirebaseLoadingStatus.loading)
                const Expanded(
                  child: ContentAreaWidget(
                    addPadding: true,
                    child: QuestionPlaceholderWidget(),
                  ),
                ),
              if (controller.loadingStatus.value ==
                  FirebaseLoadingStatus.completed)
                Expanded(
                  child: ContentAreaWidget(
                    addPadding: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestion.value!.question,
                            style: questionText,
                          ),
                          GetBuilder<QuizController>(
                            builder: (controller) {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25.0),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final answer = controller
                                      .currentQuestion.value!.answers![index];
                                  return AnswerCardWidget(
                                    onTap: () {
                                      controller
                                          .selectedAnswer(answer.identifier);
                                    },
                                    answer:
                                        "${answer.identifier.toUpperCase()}. ${answer.answer}",
                                    isSelected: answer.identifier ==
                                        controller.currentQuestion.value!
                                            .selectedAnswer,
                                    submitted: controller.submitted.value,
                                    isCorrect: controller.currentQuestion.value!
                                            .correctanswer!
                                            .toLowerCase() ==
                                        answer.identifier.toLowerCase(),
                                  );
                                },
                                separatorBuilder: (_, index) {
                                  return const SizedBox(
                                    height: 10.0,
                                  );
                                },
                                itemCount: controller
                                    .currentQuestion.value!.answers!.length,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ColoredBox(
                color: customScaffoldColor(context),
                child: Padding(
                  padding: UiParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 55.0,
                              height: 55.0,
                              child: MainButtonWidget(
                                onTap: () {
                                  controller.previousQuestion();
                                },
                                left: Icon(
                                  Icons.arrow_back_ios,
                                  color: Get.isDarkMode
                                      ? onSurfaceTextColor
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.loadingStatus.value ==
                              FirebaseLoadingStatus.completed,
                          child: SizedBox(
                            height: 55.0,
                            child: controller.isLastQuestion
                                ? MainButtonWidget(
                                    onTap: () {
                                      controller.goToOverview();
                                    },
                                    left: Text(
                                      "Complete",
                                      style: TextStyle(
                                        color: Get.isDarkMode
                                            ? onSurfaceTextColor
                                            : Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                : MainButtonWidget(
                                    onTap: () {
                                      controller.nextQuestion();
                                    },
                                    left: Obx(
                                      () => Text(
                                        controller.currentQuestion.value!
                                                    .selectedAnswer !=
                                                null
                                            ? "Next"
                                            : (controller.submitted.value
                                                ? "Next"
                                                : "Skip"),
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? onSurfaceTextColor
                                              : Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.loadingStatus.value ==
                              FirebaseLoadingStatus.completed,
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
                                child: Icon(
                                  AppIcons.menuRight,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
