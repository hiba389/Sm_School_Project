import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/screens/onboardingscreens/onboarding3.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage('assets/images/attendenc.jpg'),
            fit: BoxFit.contain),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Rectify Your\nAttendance",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenResponse.height(context) * 0.03,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: ScreenResponse.height(context) * 0.5,
                left: ScreenResponse.height(context) * 0.02),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  '/onboarding_two',
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.skyblueColor),
              child: Icon(Icons.arrow_right_outlined,
                  size: ScreenResponse.height(context) * 0.1,
                  color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
