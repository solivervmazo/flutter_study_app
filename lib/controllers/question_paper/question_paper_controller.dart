import 'package:flutter_study_app/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class QuestionPaperController extends GetxController {
  final List<String> allPaperImages = <String>[].obs;
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
      for (var imgName in imgNames) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(imgName);
        print("a $imgUrl");
        allPaperImages.add(imgUrl!);
      }
    } catch (e) {
      print(e);
    }
  }
}
