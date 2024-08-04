import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherAttendanceView extends StatelessWidget {
  const TeacherAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final name = arguments['name'] as String? ?? 'Default Name';
    final userClass = arguments['class'] as String? ?? 'Default Class';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: Text(
          '$userClass Attendance',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .where('class', isEqualTo: userClass)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Students Found'));
          }

          var students = snapshot.data!.docs;

          return ListView(
            children: students.map((student) {
              //String studentId = student.id;
              String rollnumber = student['rollnumber'];

              String studentName = student['name'];
              String role = student['role'];

              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.freepik.com/512/14365/14365803.png'), // Replace with your image URL
                ),
                subtitle: const Text(
                  "SM School System",
                  style: TextStyle(color: Colors.black),
                ),
                contentPadding: const EdgeInsets.all(10),
                title: Text(
                  studentName,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.toNamed('/teacher_attend_page', arguments: {
                    'rollnumber': rollnumber,
                    'class': userClass,
                    'name': studentName,
                    'role': role,
                  });
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
