import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/auth_controller.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:flutter_study_app/firebase/question_papers_collection_reference.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:flutter_study_app/screens/question/questions_complete_screen.dart';
import 'package:flutter_study_app/widgets/answer_card_widget.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final Rx<FirebaseLoadingStatus> loadingStatus =
      FirebaseLoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final List<Questions> allQuestions = <Questions>[].obs;
  final RxInt questionIdex = 0.obs;
  bool get isFirstQuestion => questionIdex.value > 0;
  bool get isLastQuestion => questionIdex.value == allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  int _remainingSeconds = 0;
  final time = "00.00".obs;
  final RxBool submitted = false.obs;
  late Timer _timer;

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    final QuestionPaperModel questionPaper =
        Get.arguments as QuestionPaperModel;
    loadData(questionPaper);

    super.onReady();
  }

  void loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = FirebaseLoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsSnapshot =
          await QuestionPapersCollectionReference.questionPaperCollection()
              .doc(
                questionPaper.id,
              )
              .collection("questions")
              .get();
      final List<Questions> questionsList = questionsSnapshot.docs
          .map(
            (snapshot) => Questions.fromSnapshot(
              snapshot,
            ),
          )
          .toList();
      questionPaper.questions = questionsList;

      for (Questions question in questionsList) {
        currentQuestion.value = questionPaper.questions![0];
        final QuerySnapshot<Map<String, dynamic>> answersSnapshot =
            await QuestionPapersCollectionReference.questionPaperCollection()
                .doc(
                  questionPaper.id,
                )
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();
        final List<Answers> answersList = answersSnapshot.docs
            .map(
              (snapshot) => Answers.fromSnapshot(
                snapshot,
              ),
            )
            .toList();
        question.answers = answersList;
        allQuestions.assignAll(questionPaper.questions!);
      }

      _startTimer(questionPaper.timeSeconds);
      questionPaperModel = questionPaper;
      loadingStatus.value = FirebaseLoadingStatus.completed;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.update((question) {
      question!.selectedAnswer = answer;
    });
    update([
      "answers_list",
    ]);
  }

  String get completedQuestion {
    if (submitted.value) {
      return correctAnswers;
    }
    int unanswered = allQuestions
        .where((question) => question.selectedAnswer != null)
        .toList()
        .length;
    return "$unanswered out of ${allQuestions.length} answered";
  }

  String get correctAnswers {
    int answers = allQuestions
        .where((question) =>
            question.correctanswer.toString().toLowerCase() ==
            question.selectedAnswer.toString().toLowerCase())
        .toList()
        .length;
    return "$answers correct answer${answers > 0 ? "s" : ""} out of ${allQuestions.length}";
  }

  goToQuestion(int index) {
    questionIdex.value = index;
  }

  goToOverview() {
    Get.toNamed(QuestionsCompleteScreen.routeName,
        arguments: questionPaperModel);
  }

  nextQuestion() {
    if (questionIdex.value >= allQuestions.length - 1) {
      return;
    }
    questionIdex.value++;
    currentQuestion.value = allQuestions[questionIdex.value];
  }

  AnswerStatus getStatus(int index) {
    AnswerStatus status = AnswerStatus.notanswered;
    if (allQuestions[index].selectedAnswer != null) {
      status = AnswerStatus.answered;
      if (allQuestions[index].selectedAnswer.toString().toLowerCase() ==
          allQuestions[index].correctanswer.toString().toLowerCase()) {
        status = AnswerStatus.correct;
      } else {
        status = AnswerStatus.wrong;
      }
    }
    return status;
  }

  previousQuestion() {
    if (questionIdex.value <= 0) {
      return;
    }
    questionIdex.value--;
    currentQuestion.value = allQuestions[questionIdex.value];
  }

  void _startTimer(int seconds) {
    const Duration duration = Duration(seconds: 1);
    _remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = _remainingSeconds ~/ 60;
        int seconds = _remainingSeconds % 60;
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        _remainingSeconds--;
      }
    });
  }

  void submit() {
    submitted.value = true;
    saveTestResults();
    _timer.cancel();
    update();
  }

  int get correctAnswerCount {
    return allQuestions
        .where((question) =>
            question.correctanswer.toString().toLowerCase() ==
            question.selectedAnswer.toString().toLowerCase())
        .toList()
        .length;
  }

  String get points {
    var points = (correctAnswerCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - _remainingSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  void showLeaderboards() {}

  Future<void> saveTestResults() async {
    loadingStatus.value = FirebaseLoadingStatus.loading;
    final fireStore = FirebaseFirestore.instance;
    User? user = Get.find<AuthController>().getUser();
    if (user == null) RenderSemanticsGestureHandler();

    userRF
        .doc(user!.email)
        .collection("my_recents_quiz")
        .doc(questionPaperModel.id)
        .set({
      "points": points,
      "correct_answer": correctAnswerCount,
      "total_questions": allQuestions.length,
      "question_id": questionPaperModel.id,
      "remaining_time": _remainingSeconds,
    });

    await QuestionPapersCollectionReference.questionPaperCollection()
        .doc(questionPaperModel.id)
        .update({
      "attempts": FieldValue.arrayUnion([
        {
          "user": user.email,
          "points": points,
        }
      ])
    });

    loadingStatus.value = FirebaseLoadingStatus.completed;
  }
}
