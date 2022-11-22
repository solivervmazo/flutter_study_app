import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/controllers/app_zoom_controller.dart';
import 'package:flutter_study_app/controllers/auth_controller.dart';
import 'package:flutter_study_app/widgets/drawer_button_widget.dart';
import 'package:get/get.dart';

class MenuScreen extends GetView<AppZoomController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    User? user = authController.getUser();
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style:
                    TextButton.styleFrom(foregroundColor: onSurfaceTextColor))),
        child: Drawer(
          width: Get.width,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      accountEmail: authController.isLoggedIn()
                          ? Text(
                              user!.displayName!,
                            )
                          : const Text(
                              "",
                            ),
                      accountName: authController.isLoggedIn()
                          ? Text(
                              user!.email!,
                            )
                          : const Text(""),
                      currentAccountPicture: Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          imageUrl: authController.isLoggedIn()
                              ? user!.photoURL!
                              : "",
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 90.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ...(authController.isLoggedIn() ? [] : [])
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  authController.isLoggedIn()
                      ? DrawerButtonWidget(
                          onPressed: () async {
                            await authController.logout();
                            Get.offAllNamed("/signin");
                          },
                          icon: Icons.exit_to_app,
                          label: "logout",
                        )
                      : DrawerButtonWidget(
                          onPressed: () async {
                            Get.offAllNamed("/signin");
                          },
                          icon: Icons.login,
                          label: "Sign in",
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
