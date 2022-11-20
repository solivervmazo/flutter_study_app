import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class QuestionPapersCollectionReference {
  // QuestionPapersCollectionReference();

  // final String docId;

  static CollectionReference<Map<String, dynamic>> questionPaperCollection() {
    return _fireStore.collection("questionPaper");
  }

  static DocumentReference questionPaperDocReference(
      {required String questionPaperId}) {
    return _fireStore.collection("questionPaper").doc(questionPaperId);
  }

  static DocumentReference questionsDocReference(
      {required DocumentReference questionPaperDocReference,
      required String questionId}) {
    return questionPaperDocReference.collection("questions").doc(questionId);
  }

  static DocumentReference answersDocReference({
    required DocumentReference questionsDocReference,
    required String answerId,
  }) {
    return questionsDocReference.collection("answers").doc(answerId);
  }

  //
}
