import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';

class AppZoomController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  @override
  void onReady() {
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {}

  void sigIn() {}

  void website() {}

  void email() {
    final Uri emailLaunchUri =
        Uri(scheme: "mailto", path: "solivervmazo.jobs@gmail.com");
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    // if( !await launch(url)){
    //   throw "could not launc $url";
    // }
  }
}
