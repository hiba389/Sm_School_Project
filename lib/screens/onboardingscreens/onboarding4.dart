import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/screens/authentication/role_and_forgot/guestmode.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/images/result1.jpg'),
              fit: BoxFit.contain),
        ),
//SizedBox(height: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Student's Results\nOr ReportCards",
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
                    '/onboarding_four',
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.indigo[800]),
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
