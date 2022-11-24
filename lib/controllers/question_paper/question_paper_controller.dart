import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_app/controllers/auth_controller.dart';
import 'package:flutter_study_app/controllers/question_paper/quiz_controller.dart';
import 'package:flutter_study_app/firebase/question_papers_collection_reference.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:flutter_study_app/screens/question/questions_screen.dart';
import 'package:flutter_study_app/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class QuestionPaperController extends GetxController {
  final List<String> allPaperImages = <String>[].obs;
  final List<QuestionPaperModel> allPapers = <QuestionPaperModel>[].obs;
  late QuestionPaperModel selectedQuestion;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgNames = <String>[
      "biology",
      "chemistry",
      "maths",
      "physics",
    ];
    try {
      QuerySnapshot<Map<String, dynamic>> paperQuerySnapshot =
          await QuestionPapersCollectionReference.questionPaperCollection()
              .get();
      final List<QuestionPaperModel> paperList = paperQuerySnapshot.docs
          .map(
            (snapshot) => QuestionPaperModel.fromSnapshot(snapshot),
          )
          .toList();

      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }

      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  navigateToQuestions({
    required QuestionPaperModel paper,
    bool tryAgain = false,
  }) {
    AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      selectedQuestion = paper;
      if (tryAgain) {
        // Get.offNamed("/home");
        Get.delete<QuizController>();
        Get.offAndToNamed(
          QuestionsScreen.routeName,
          arguments: paper,
        );
      } else {
        Get.toNamed(QuestionsScreen.routeName, arguments: paper);
      }
    } else {
      authController.showLoginAlertDialog();
    }
  }

  bool isAttempted(List<dynamic>? attempts) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    return attempts!
        .where((attemtp) => attemtp["user"] == user.email)
        .toList()
        .isNotEmpty;
  }
}
