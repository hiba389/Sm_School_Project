import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/chats/chat.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/screens/dashboards/school_details.dart';
import 'package:school_app/screens/dashboards/student/pages/studentTimetable.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/examination/teacherExamination.dart';
import 'package:school_app/screens/dashboards/student/pages/notification.dart';
import 'package:school_app/screens/dashboards/student/pages/reportcard.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();
    // Retrieve arguments safely with default values
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final name = arguments['name'] as String? ?? 'Default Name';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final role = arguments['role'] as String? ?? 'Default Role';
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {
              switch (value) {
                case 'School Details':
                  Get.to(() => const SchoolDetailsPage());
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'School Details'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: Text(
          'Welcome Miss $name',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: ScreenResponse.height(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/teacher_homework', arguments: {
                      'name': name,
                      'class': userClass,
                      'role': role,
                    });
                  },
                  child: Container(
                    width: ScreenResponse.height(context) * 0.1,
                    height: ScreenResponse.height(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://img.pikbest.com/origin/10/50/56/762pIkbEsTb5F.jpg!w700wp'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/teacher_attendance', arguments: {
                      'name': name,
                      'class': userClass,
                      'role': role,
                    });
                  },
                  child: Container(
                    width: ScreenResponse.height(context) * 0.1,
                    height: ScreenResponse.height(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/003/407/568/non_2x/schedule-and-planning-concept-event-and-task-force-illustration-vector.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/syllabus_page', arguments: {
                      'name': name,
                      'class': userClass,
                      'role': role,
                    });
                  },
                  child: Container(
                    width: ScreenResponse.height(context) * 0.1,
                    height: ScreenResponse.height(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtxSisu1Mdb1OOy6tajCJMypPVKssRJVGU3Q&s'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenResponse.height(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ' HomeWork',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenResponse.height(context) * 0.02,
                      color: Colors.black),
                ),
                Text(
                  'Class\nSchedule',
                  style: TextStyle(
                      fontSize: ScreenResponse.height(context) * 0.02,
                      color: const Color.fromARGB(255, 37, 33, 33)),
                ),
                Text(
                  '  Exam\nSchedule',
                  style: TextStyle(
                      fontSize: ScreenResponse.height(context) * 0.02,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: ScreenResponse.height(context) * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/teacher_listexamview', arguments: {
                      'name': name,
                      'class': userClass,
                      'role': role,
                    });
                  },
                  child: Container(
                    width: ScreenResponse.height(context) * 0.1,
                    height: ScreenResponse.height(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/college-entrance-exam-concept-illustration_114360-10232.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      '/chatPage',
                      parameters: {
                        'userClass': userClass,
                        'role': role,
                      },
                    );
                  },
                  child: Container(
                    width: ScreenResponse.height(context) * 0.1,
                    height: ScreenResponse.height(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsULZGoAiKRWnXGGcEhk6qoAnb-MKxGNHahg&s'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/teacher_listattendaceview', arguments: {
                      'name': name,
                      'class': userClass,
                      'role': role,
                    });
                  },
                  child: Container(
                    width: ScreenResponse.height(context) * 0.1,
                    height: ScreenResponse.height(context) * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhv_f6T0eItiCZyV4r3sUST7z8S940P-_oU09a7Py1VO9DTwyz_vZqW7Yd5JTM8iELjwU&usqp=CAU'),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenResponse.height(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ' Examination',
                  style: TextStyle(
                      fontSize: ScreenResponse.height(context) * 0.02,
                      color: Colors.black),
                ),
                Text(
                  '  Conversation',
                  style: TextStyle(
                      fontSize: ScreenResponse.height(context) * 0.02,
                      color: Colors.black),
                ),
                Text(
                  '  Attendence',
                  style: TextStyle(
                      fontSize: ScreenResponse.height(context) * 0.02,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: ScreenResponse.height(context) * 0.04),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenResponse.width(context) * 0.07,
                  right: ScreenResponse.width(context) * 0.07),
              child: SizedBox(
                height: ScreenResponse.height(context) * 0.06,
                width: ScreenResponse.width(context) * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.red,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenResponse.height(context) * .024,
                      ),
                    ),
                    onPressed: () {
                      firebaseService.signout();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
