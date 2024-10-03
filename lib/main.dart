// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/splash_screen.dart';
import 'constants.dart' as constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: constants.secondaryBlueColour),
          primaryColor: constants.secondaryBlueColour,
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: constants.textGrayColour),
          scaffoldBackgroundColor:
              constants.mainBackgroundColour, // standardise all bg colour
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: SplashScreen());
  }
}
