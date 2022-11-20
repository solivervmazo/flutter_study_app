import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/controllers/app_zoom_controller.dart';
import 'package:flutter_study_app/widgets/drawer_button_widget.dart';
import 'package:get/get.dart';

class MenuScreen extends GetView<AppZoomController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: const [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      accountEmail: Text(
                        "soliver@gmail.com",
                      ),
                      accountName: Text(
                        "Soliver Mazo",
                      ),
                      currentAccountPicture: Icon(
                        Icons.account_circle,
                        size: 90.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  DrawerButtonWidget(
                    icon: Icons.exit_to_app,
                    label: "logout",
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
