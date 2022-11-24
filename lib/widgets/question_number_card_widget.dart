import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';
import 'package:flutter_study_app/screens/question/questions_screen.dart';
import 'package:flutter_study_app/widgets/answer_card_widget.dart';
import 'package:get/get.dart';

class QuestionNumberCardWidget extends StatelessWidget {
  const QuestionNumberCardWidget({
    super.key,
    required this.index,
    this.status,
    required this.onTap,
    this.submitted = false,
  });

  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;
  final bool submitted;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        backgroundColor = Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.notanswered:
        backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        break;
      default:
        backgroundColor = Theme.of(context).primaryColor;
        break;
    }
    return InkWell(
      onTap: onTap,
      borderRadius: UiParameters.cardBorderRadius,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: UiParameters.cardBorderRadius,
          color: submitted
              ? backgroundColor
              : (status != AnswerStatus.notanswered
                  ? answerSelectedColor()
                  : Theme.of(context).cardColor),
          border: Border.all(
            color: submitted
                ? backgroundColor.withAlpha(120)
                : answerBorderColor(),
          ),
        ),
        child: Text(
          (index + 1).toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color:
                status != AnswerStatus.notanswered ? onSurfaceTextColor : null,
          ),
        ),
      ),
    );
  }
}
