import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColorDark = Color(0xFF2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);

const Color primaryTextColor = Color.fromARGB(255, 40, 40, 40);

class AppDarkTheme with SubThemeDataMixin {
  ThemeData buildDarkTheme() {
    final ThemeData themeData = ThemeData.dark();
    return themeData.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextTheme().apply(
        bodyColor: primaryTextColor,
        displayColor: primaryTextColor,
      ),
    );
  }
}
