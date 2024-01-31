import 'package:flutter/material.dart';
import 'package:todo_app_patrizia/core/global/theme/color_theme.dart';

class ThemeApp {
  static ThemeData themelight = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorTheme.azalea),
    scaffoldBackgroundColor: ColorTheme.carouselPink,
    hintColor: ColorTheme.silverChalice2,
    cardColor: ColorTheme.carouselPink,
    dividerColor: ColorTheme.tundora2,
    disabledColor: ColorTheme.coldTurkey,
    fontFamily: "nahid",
    iconTheme: IconThemeData(
      color: ColorTheme.tundora2,
    ),
  );
}
