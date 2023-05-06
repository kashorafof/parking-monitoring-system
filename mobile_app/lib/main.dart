import 'package:flutter/material.dart';
import 'package:mobile_app/models/constants.dart';
import 'package:mobile_app/views/login_view.dart';
import 'package:mobile_app/views/file_violation_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor blackSwatch = MaterialColor(
      0xFF000000,
      <int, Color>{
        50: Color(0xFF000000),
        100: Color(0xFF000000),
        200: Color(0xFF000000),
        300: Color(0xFF000000),
        400: Color(0xFF000000),
        500: Color(0xFF000000),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      },
    );

    return MaterialApp(
      title: 'Navigation Demo',
      
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
        ),
      ),
      home: LoginPage(),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

