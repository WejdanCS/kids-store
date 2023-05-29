import 'package:flutter/material.dart';
import 'package:kids_store_app/pages/home_page.dart';
import 'package:kids_store_app/pages/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'utlis/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor mainAppColor =
        MaterialColor(Constants.primaryColor.value, const <int, Color>{
      50: Constants.primaryColor,
      100: Constants.primaryColor,
      200: Constants.primaryColor,
      300: Constants.primaryColor,
      400: Constants.primaryColor,
      500: Constants.primaryColor,
      600: Constants.primaryColor,
      700: Constants.primaryColor,
      800: Constants.primaryColor,
      900: Constants.primaryColor,
    });
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    return MaterialApp(
      locale: const Locale("ar"),
      debugShowCheckedModeBanner: false,
      title: 'كيدز ستور',
      theme: ThemeData(
        primarySwatch: mainAppColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Constants.primaryColor, //<-- SEE HERE
        ),
        fontFamily: "Tajwal",
      ),
      builder: EasyLoading.init(),
      home: LoginPage(),
    );
  }
}
