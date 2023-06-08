import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kids_store_app/pages/home_page.dart';
import 'package:kids_store_app/pages/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kids_store_app/pages/register.dart';
import 'package:kids_store_app/providers/add_to_cart_provider.dart';
import 'package:kids_store_app/providers/favorites_provder.dart';
import 'package:kids_store_app/providers/products_provider.dart';
import 'package:kids_store_app/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'utlis/constants.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Constants.primaryColor, // navigation bar color
    statusBarColor: Constants.primaryColor, // status bar color
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CartModel()),
    ChangeNotifierProvider(create: (context) => ProductsProvider()),
    ChangeNotifierProvider(create: (context) => FavoritesProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? prefs;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        isLoading = false;
      });
      if (isUserLoggedIn()) {
        String? token = prefs!.getString('token');
        if (token != null) {
          Provider.of<UserProvider>(context, listen: false).addToken(token);
        }
      } else {}
    });
  }

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
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar"),
      ],
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
      // home: LoginPage(),
      home: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("جاري التحميل"),
                Center(child: CircularProgressIndicator()),
              ],
            )
          : isUserLoggedIn()
              ? const HomePage()
              : const LoginPage(),
    );
  }

  bool isUserLoggedIn() {
    return prefs?.getBool('isLoggedIn') ?? false;
  }
}
