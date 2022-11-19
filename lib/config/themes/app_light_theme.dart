import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFF3ac3cb);
const Color primaryColorLight = Color(0xFFF85187);
const Color primaryTextColor = Color.fromARGB(255, 40, 40, 40);

class AppLightTheme with SubThemeDataMixin {
  ThemeData buildLightTheme() {
    final ThemeData themeData = ThemeData.light();
    return themeData.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextTheme().apply(
        bodyColor: primaryTextColor,
        displayColor: primaryTextColor,
      ),
    );
  }
}
