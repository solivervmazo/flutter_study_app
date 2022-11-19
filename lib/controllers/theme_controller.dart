import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_dark_theme.dart';
import 'package:flutter_study_app/config/themes/app_light_theme.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  @override
  void onInit() {
    initializeThemeData();
    super.onInit();
  }

  initializeThemeData() {
    _darkTheme = AppDarkTheme().buildDarkTheme();
    _lightTheme = AppLightTheme().buildLightTheme();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
}
