import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/question_paper/data_uploader.dart';
import 'package:flutter_study_app/dev/test_scaffold_widget.dart';
import 'package:flutter_study_app/firebase/firebase_loading_status.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  final DataUploader controller = Get.put(DataUploader());
  @override
  Widget build(BuildContext context) {
    return TestScaffoldWidget(
      child: Obx(
        () => Text(
          controller.firebaseLoadingStatus.value ==
                  FirebaseLoadingStatus.completed
              ? "Uploaded"
              : "Uploading...",
        ),
      ),
    );
  }
}
