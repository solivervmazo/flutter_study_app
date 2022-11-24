import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';

enum AnswerStatus {
  correct,
  wrong,
  answered,
  notanswered,
}

class AnswerCardWidget extends StatelessWidget {
  const AnswerCardWidget({
    super.key,
    required this.onTap,
    required this.answer,
    required this.isSelected,
    this.submitted = false,
    this.isCorrect = false,
  });

  final VoidCallback onTap;
  final String answer;
  final bool isSelected;
  final bool submitted;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: submitted ? null : onTap,
      borderRadius: UiParameters.cardBorderRadius,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: UiParameters.cardBorderRadius,
          color: isSelected
              ? (submitted
                  ? (isCorrect ? correctAnswerColor : wrongAnswerColor)
                  : answerSelectedColor())
              : (submitted
                  ? (isCorrect
                      ? correctAnswerColor
                      : Theme.of(context).cardColor)
                  : Theme.of(context).cardColor),
          border: Border.all(
            color: isSelected ? answerSelectedColor() : answerBorderColor(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: TextStyle(
                color: isSelected ? onSurfaceTextColor : null,
              ),
            ),
            Visibility(
              visible: submitted,
              child: Icon(
                Icons.lock_rounded,
                color: isSelected ? onSurfaceTextColor : Colors.grey.shade500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
