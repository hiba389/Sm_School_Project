import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/screens/dashboards/school_details.dart';

import 'package:school_app/services/functionalities/firebase/firebase_service.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();
    // Retrieve arguments safely with default values
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final name = arguments['name'] as String? ?? 'Default Name';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final role = arguments['role'] as String? ?? 'Default Role';
    final rollnumber =
        arguments['rollnumber'] as String? ?? 'Default RollNumber';
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
          'Welcome  $name',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenResponse.height(context) * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/homework', arguments: {
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
                      Get.toNamed('/dailyDiaryPage', arguments: {
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
                                'https://cdn3.vectorstock.com/i/1000x1000/15/37/school-background-with-education-items-vector-43511537.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/Timetable', arguments: {
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
                ],
              ),
              SizedBox(height: ScreenResponse.height(context) * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '   HomeWork',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Text(
                    '  Daily Diary',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Text(
                    'Class Schedule',
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
                      Get.toNamed('/feePage', arguments: {
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
                                'https://static.vecteezy.com/system/resources/thumbnails/033/491/391/small/modern-design-icon-of-graduate-vector.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/profilePage', arguments: {
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
                                'https://i.pinimg.com/736x/b8/49/2f/b8492fc6a3c1b67e49caec08eaef085e.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             const ReportCardPage()));
                      Get.toNamed('/reportCardPage', arguments: {
                        'name': name,
                        'class': userClass,
                        'role': role,
                        'rollnumber': rollnumber,
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
                    ' Fee Details',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Text(
                    '  Report Cards',
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
                      Get.toNamed('/calenderPage', arguments: {
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
                                'https://www.wilmingtoncityschools.com/media/site/district-news/calendar%20page-714.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/noticeBoard', arguments: {
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
                                'https://media.istockphoto.com/id/904999860/vector/cork-notice-board.jpg?s=612x612&w=0&k=20&c=AXK2FJ3aslwCUmCfAA-hcdKnlKa3FVV9DuwOATl_rC0='),
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
                ],
              ),
              SizedBox(height: ScreenResponse.height(context) * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Calendar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Center(
                    child: Text(
                      '      Notice Board',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenResponse.height(context) * 0.02,
                          color: Colors.black),
                    ),
                  ),
                  Text(
                    'Conversation',
                    textAlign: TextAlign.center,
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
                      Get.toNamed('/student_attend', arguments: {
                        'name': name,
                        'class': userClass,
                        'role': role,
                      });
                      // Get.toNamed('/feePage', arguments: {
                      //   'name': name,
                      //   'class': userClass,
                      //   'role': role,
                      // });
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
                  InkWell(
                    onTap: () {
                      Get.toNamed('/quiz_page', arguments: {
                        'name': name,
                        'class': userClass,
                        'role': role,
                        'rollnumber': rollnumber,
                      });
                    },
                    child: Container(
                      width: ScreenResponse.height(context) * 0.1,
                      height: ScreenResponse.height(context) * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe8Hui7Eup_I4vMUFb0-hgGZyN3NrbaJUtHTJhAl_DCBEoU8tbNro71krdsJiirJlkkoc&usqp=CAU'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/student_syllabus_page', arguments: {
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
                ],
              ),
              SizedBox(height: ScreenResponse.height(context) * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Attendence',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Exam Results',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Exam\nSchedule',
                    style: TextStyle(
                        fontSize: ScreenResponse.height(context) * 0.02,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
      ),
    );
  }
}
