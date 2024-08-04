import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/screens/onboardingscreens/onboarding.dart';
import 'package:school_app/screens/splashscreen/splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(() => const HomePage());
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.deepOrange,
          Colors.white,
          // Colors.indigo,
          Colors.indigo,
          // Colors.indigo,
          Colors.white,
          Colors.indigo,
          Colors.deepOrange,
          Colors.indigo,
          // Colors.indigo,
          Colors.white,
          //  Colors.indigo,
          Colors.indigo,
          // Colors.indigo,
          Colors.deepOrange
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: ScreenResponse.height(context) * .25,
              color: Colors.white,
            ),
            SizedBox(height: ScreenResponse.height(context) * .01),
            const ArcText(
              startAngleAlignment: StartAngleAlignment.center,
              radius: 200,
              startAngle: 50,
              interLetterAngle: 0.05,
              text: "       SM SCHOOL APP",
              //direction: Direction.clockwise,
              textStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
