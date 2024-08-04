import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/screens/onboardingscreens/onboarding4.dart';

class OnBoardingPage2 extends StatefulWidget {
  const OnBoardingPage2({super.key});

  @override
  State<OnBoardingPage2> createState() => _OnBoardingPage2State();
}

class _OnBoardingPage2State extends State<OnBoardingPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/images/hw10.png'),
              fit: BoxFit.contain),
        ),
//SizedBox(height: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenResponse.height(context) * 0.02),
              child: Text(
                "Student's\nExams",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenResponse.height(context) * 0.03,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScreenResponse.height(context) * 0.5,
                  left: ScreenResponse.height(context) * 0.02),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    '/onboarding_three',
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: Colors.amber),
                child: Icon(Icons.arrow_right_outlined,
                    size: ScreenResponse.height(context) * 0.1,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
