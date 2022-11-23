import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/custom_text_style.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';
import 'package:flutter_study_app/controllers/question_paper/questions_controller.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:flutter_study_app/widgets/answer_card_widget.dart';
import 'package:flutter_study_app/widgets/background_decoration_widget.dart';
import 'package:flutter_study_app/widgets/content_area_widget.dart';
import 'package:flutter_study_app/widgets/main_button_widget.dart';
import 'package:flutter_study_app/widgets/question_placeholder_widget.dart';
import 'package:get/get.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  static const String routeName = "question_screen";

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecorationWidget(
        child: Obx(
          () => Column(
            // mainAxisSize: MainAxisSize.max
            children: [
              //TODO
              SizedBox(
                height: 70.0,
                child: Center(
                  child: Text(
                      "${controller.questionIdex.value + 1} of ${controller.allQuestions.length} questions"),
                ),
              ),
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
                          GetBuilder<QuestionsController>(
                            assignId: true,
                            id: "answers_list",
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
                                      controller.nextQuestion();
                                    },
                                    left: Text(
                                      "Submit",
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
                                    left: Text(
                                      "Next",
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
