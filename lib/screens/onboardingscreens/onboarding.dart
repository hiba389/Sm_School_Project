import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';

import 'package:school_app/screens/onboardingscreens/onboarding2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/images/girl2.png'),
              fit: BoxFit.contain),
        ),
//SizedBox(height: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //300 for regular
            //600 bold
            Text(
              "Mark HomeWork\nAs Completed",
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
                    '/onboarding_one',
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: AppColors.brownColor),
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
