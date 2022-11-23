import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:flutter_study_app/firebase/question_papers_collection_reference.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  final Rx<FirebaseLoadingStatus> loadingStatus =
      FirebaseLoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final List<Questions> allQuestions = <Questions>[];
  final RxInt questionIdex = 0.obs;
  bool get isFirstQuestion => questionIdex.value > 0;
  bool get isLastQuestion => questionIdex.value == allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
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
      questionPaperModel = questionPaper;
      loadingStatus.value = FirebaseLoadingStatus.completed;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update([
      "answers_list",
    ]);
  }

  nextQuestion() {
    if (questionIdex.value >= allQuestions.length - 1) {
      return;
    }
    questionIdex.value++;
    currentQuestion.value = allQuestions[questionIdex.value];
  }

  previousQuestion() {
    print("questionIdex: $questionIdex");
    if (questionIdex.value <= 0) {
      return;
    }
    questionIdex.value--;
    currentQuestion.value = allQuestions[questionIdex.value];
  }
}
