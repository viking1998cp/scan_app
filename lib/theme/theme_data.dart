import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig();

  static ThemeData createTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color accentColor,
    required Color primaryTextColor,
    required Color secondTextColor,
    required Color thirdTextColor,
    required Color fourthTextColor,
    required Color fifthTextColor,
    required Color primaryBackgroundColor,
    required Color error,
    Color? hintText,
    Color? divider,
    Color? disabled,
    Color? shadowColor,
    Color? primaryBorderColor,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      buttonColor: primaryColor,
      canvasColor: primaryBackgroundColor,
      cardColor: primaryBackgroundColor,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: primaryBackgroundColor,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryBorderColor!, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: shadowColor,
      ),
      backgroundColor: primaryBackgroundColor,
      primaryColor: primaryColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
      ),
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: IconThemeData(
          color: secondTextColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: secondTextColor,
        size: 16,
      ),
      errorColor: error,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: primaryColor,
          primaryVariant: accentColor,
          secondary: accentColor,
          secondaryVariant: accentColor,
          surface: primaryBackgroundColor,
          background: primaryColor,
          error: error,
          onPrimary: primaryTextColor,
          onSecondary: primaryTextColor,
          onSurface: primaryTextColor,
          onBackground: primaryTextColor,
          onError: primaryTextColor,
        ),
        padding: const EdgeInsets.all(16),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: 'roboto',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: primaryTextColor.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      fontFamily: 'roboto',
      unselectedWidgetColor: Colors.grey,
      textTheme: TextTheme(
        /// headline1 Color: primaryTextColor -> Black Gray (#333333)
        headline1: baseTextTheme.headline1!.copyWith(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        /// headline2 Color: secondTextColor -> White
        headline2: baseTextTheme.headline2!.copyWith(
          color: secondTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        /// headline3 Color: thirdTextColor -> Black (#000000)
        headline3: baseTextTheme.headline3!.copyWith(
          color: thirdTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        /// headline4 Color: fourthTextColor -> Green
        headline4: baseTextTheme.headline4!.copyWith(
          color: fourthTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        /// headline5 Color: fifthTextColor -> Gray
        headline5: baseTextTheme.headline5!.copyWith(
          color: fifthTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        /// headline6 Color: primaryTextColor -> Black Gray (#333333)
        headline6: baseTextTheme.headline6!.copyWith(
          color: primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),

        /// bodyText1 Color: primaryTextColor -> Black Gray (#333333)
        bodyText1: baseTextTheme.bodyText1!.copyWith(
          color: primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),

        /// bodyText2 Color: secondTextColor -> White
        bodyText2: baseTextTheme.bodyText2!.copyWith(
          color: primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),

        /// subtitle1 Color: primaryTextColor -> Black Gray (#333333)
        subtitle1: baseTextTheme.subtitle1!.copyWith(
          color: primaryTextColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),

        /// subtitle2 Color: fifthTextColor -> Gray
        subtitle2: baseTextTheme.subtitle2!.copyWith(
          color: fifthTextColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        button: baseTextTheme.button!.copyWith(
          color: secondTextColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        caption: baseTextTheme.caption!.copyWith(
          color: primaryTextColor,
          fontSize: 11,
          fontWeight: FontWeight.w300,
        ),
        overline: baseTextTheme.overline!.copyWith(
          color: primaryTextColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        primaryColor: AppColor.primaryColorLight,
        primaryBackgroundColor: AppColor.primaryBackgroundColorLight,
        primaryTextColor: AppColor.primaryTextColorLight,
        secondTextColor: AppColor.secondTextColorLight,
        thirdTextColor: AppColor.thirdTextColorLight,
        fourthTextColor: AppColor.fourthTextColorLight,
        fifthTextColor: AppColor.fifthTextColorLight,
        hintText: AppColor.primaryHintColorLight,
        accentColor: AppColor.accentColorLight,
        divider: AppColor.dividerColorLight,
        disabled: AppColor.disabledColorLight,
        shadowColor: AppColor.shadowColorLight,
        primaryBorderColor: AppColor.primaryBorderColorLight,
        error: AppColor.errorColorLight,
      );

// static ThemeData get darkTheme => createTheme(
//       brightness: Brightness.dark,
//       primaryColor: AppColor.primaryColorDark,
//       primaryBackgroundColor: AppColor.primaryBackgroundColorDark,
//       primaryTextColor: AppColor.primaryTextColorDark,
//       secondTextColor: AppColor.secondTextColorDark,
//       hintText: AppColor.primaryHintColorDark,
//       accentColor: AppColor.accentColorDark,
//       divider: AppColor.dividerColorDark,
//       disabled: AppColor.disabledColorDark,
//       shadowColor: AppColor.shadowColorDark,
//       primaryBorderColor: AppColor.primaryBorderColorDark,
//       error: AppColor.errorColorDark,
//     );
}
