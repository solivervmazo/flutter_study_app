import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/config/themes/app_colors.dart';
import 'package:flutter_study_app/config/themes/ui_parameters.dart';

TextStyle cardTitle(context) => TextStyle(
      color: UiParameters.isDarkMode()
          ? Theme.of(context).textTheme.bodyText1!.color
          : Theme.of(context).primaryColor,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
const TextStyle detailText = TextStyle(
  fontSize: 12.0,
);

const TextStyle headerText = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: onSurfaceTextColor,
);
