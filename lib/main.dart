import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/services/app/apppage.dart';
import 'package:school_app/services/functionalities/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconButtonTheme: const IconButtonThemeData(
            style:
                ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white))),
        fontFamily: 'Kollektif',
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16.0,
          ),
        )),
        scaffoldBackgroundColor: Colors.white,
      ),
      getPages: AppPages.pages,
      initialRoute: AppPages.initialRoute,
    );
  }
}
