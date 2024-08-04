import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/screens/dashboards/student/pages/resultCard.dart';

class ReportCardPage extends StatelessWidget {
  const ReportCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final name = arguments['name'] as String? ?? 'Default Name';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final role = arguments['role'] as String? ?? 'Default Role';
    final rollnumber =
        arguments['rollnumber'] as String? ?? 'Default RollNumber';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo[800],
        title: Text(
          " Report Cards",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenResponse.height(context) * .023),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: ScreenResponse.height(context) * .03,
          left: ScreenResponse.width(context) * .05,
          right: ScreenResponse.width(context) * .05,
        ),
        children: List.generate(1, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.school,
                      color: Colors.deepOrange,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$userClass Results",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenResponse.height(context) * .02,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed('/result_card_page', arguments: {
                      'name': name,
                      'class': userClass,
                      'role': role,
                      'rollnumber': rollnumber,
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.deepOrange,
                    size: 33,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
