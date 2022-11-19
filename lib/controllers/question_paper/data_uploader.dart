import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:flutter_study_app/firebase/question_papers_collection_reference.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  final Rx<FirebaseLoadingStatus> firebaseLoadingStatus =
      FirebaseLoadingStatus.loading.obs;

  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  Future<void> uploadData() async {
    firebaseLoadingStatus.value = FirebaseLoadingStatus.loading;

    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(
      Get.context!,
    ).loadString(
      "AssetManifest.json",
    );
    final Map<String, dynamic> manifestMap = jsonDecode(
      manifestContent,
    );
    //* get papers.json paths
    final papersInAssets = manifestMap.keys
        .where(
          (element) =>
              element.startsWith(
                "assets/DB/papers/",
              ) &&
              element.endsWith(".json"),
        )
        .toList();
    List<QuestionPaperModel> questionsPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionsPapers.add(
        QuestionPaperModel.fromJson(
          jsonDecode(
            stringPaperContent,
          ),
        ),
      );
    }
    WriteBatch batch = fireStore.batch();

    for (var paper in questionsPapers) {
      DocumentReference questionPaperDocReference =
          QuestionPapersCollectionReference.questionPaperDocReference(
        questionPaperId: paper.id,
      );
      batch.set(
        questionPaperDocReference,
        paper.toJson(remove: ["questions"]),
      );
      for (var question in paper.questions!) {
        DocumentReference questionsDocReference =
            QuestionPapersCollectionReference.questionsDocReference(
          questionPaperDocReference: questionPaperDocReference,
          questionId: question.id,
        );
        batch.set(
          questionsDocReference,
          question.toJson(remove: ["answers"]),
        );
        for (var answer in question.answers ?? <Answers>[]) {
          batch.set(
            QuestionPapersCollectionReference.answersDocReference(
              questionsDocReference: questionsDocReference,
              answerId: answer.identifier,
            ),
            answer.toJson(),
          );
        }
      }
    }
    await batch.commit();
    firebaseLoadingStatus.value = FirebaseLoadingStatus.completed;
  }
}
