import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/screens/authentication/student_auth/studentPin.dart';
import 'package:school_app/screens/authentication/teacher_auth/teacher_pin.dart';
import 'package:school_app/screens/dashboards/school_details.dart';

class GuestMode extends StatelessWidget {
  const GuestMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: ScreenResponse.height(context) * 0.6,
            decoration: const ShapeDecoration(
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.school,
                  size: ScreenResponse.height(context) * 0.3,
                  color: Colors.indigo[800],
                ),
                Center(
                  child: Text(
                    "SM SCHOOL SYSTEM",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenResponse.height(context) * 0.03,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Center(
                  child: Text(
                    "Login As",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.indigo[600],
                        fontSize: ScreenResponse.height(context) * 0.03,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenResponse.width(context) * 0.07,
                top: ScreenResponse.height(context) * 0.05,
                right: ScreenResponse.width(context) * 0.07),
            child: SizedBox(
              height: ScreenResponse.height(context) * 0.06,
              width: ScreenResponse.width(context) * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      backgroundColor: Colors.indigo[600]),
                  child: Text(
                    "Student Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenResponse.height(context) * .024,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const VerificationScreen()));
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenResponse.width(context) * 0.07,
                top: ScreenResponse.height(context) * 0.02,
                right: ScreenResponse.width(context) * 0.07),
            child: SizedBox(
              height: ScreenResponse.height(context) * 0.06,
              width: ScreenResponse.width(context) * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      backgroundColor: Colors.deepOrange),
                  child: Text(
                    "Teacher Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenResponse.height(context) * .024,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const VerificationTeacher()));
                  }),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: ScreenResponse.width(context) * 0.07,
          //       top: ScreenResponse.height(context) * 0.02,
          //       right: ScreenResponse.width(context) * 0.07),
          //   child: SizedBox(
          //     height: ScreenResponse.height(context) * 0.06,
          //     width: ScreenResponse.width(context) * 0.9,
          //     child: ElevatedButton.icon(
          //       icon: Icon(
          //         Icons.history_edu,
          //         size: ScreenResponse.height(context) * 0.03,
          //         color: Colors.white,
          //       ),
          //       style: ElevatedButton.styleFrom(
          //           shape: const RoundedRectangleBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(12))),
          //           backgroundColor: Colors.blue),
          //       label: Text(
          //         "School History",
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //           fontSize: ScreenResponse.height(context) * .024,
          //         ),
          //       ),
          //       onPressed: () {
          //         Get.to(() => const SchoolDetailsPage());
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
