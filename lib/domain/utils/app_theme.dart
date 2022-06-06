import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweets_emoji_example/domain/utils/colors.dart';

class AppTheme {
  const AppTheme._();

  static final _lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
    ),
    brightness: Brightness.light,
    backgroundColor: AppColors.whiteColor1,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    errorColor: AppColors.errorColor,
    disabledColor: AppColors.grayColor1,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor1,
      hintStyle: GoogleFonts.montserrat(
        color: AppColors.primaryColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(0.35),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w400,
      ),
      headline1: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.greenColor1,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: GoogleFonts.montserrat(
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.blackColor1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.primaryColor,
        ),
      ),
    ),
  );

  static final _darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
    ),
    brightness: Brightness.dark,
    backgroundColor: AppColors.blackColor1,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    errorColor: AppColors.errorColor,
    disabledColor: AppColors.grayColor1,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.montserrat(
        color: AppColors.primaryColor,
      ),
      filled: true,
      fillColor: AppColors.blackColor1,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(0.35),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w400,
      ),
      headline1: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.greenColor1,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: GoogleFonts.montserrat(
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.whiteColor1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.primaryColor,
        ),
      ),
    ),
  );

  static ThemeData light() {
    return _lightTheme;
  }

  static ThemeData dark() {
    return _darkTheme;
  }
}
