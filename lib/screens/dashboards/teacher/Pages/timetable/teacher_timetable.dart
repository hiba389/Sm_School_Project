import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/constant/data.dart';

class TeacherTimetable extends StatefulWidget {
  const TeacherTimetable({Key? key}) : super(key: key);

  @override
  _TeacherTimetableState createState() => _TeacherTimetableState();
}

class _TeacherTimetableState extends State<TeacherTimetable> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};

  final Map<String, Map<String, bool>> _daySubjectStatus = {};

  @override
  void initState() {
    super.initState();

    // Initialize subject status for each day
    for (var day in days) {
      _daySubjectStatus[day] = {for (var subject in subjects) subject: false};
    }

    // Fetch existing timetable data
    _fetchTimetable();
  }

  Future<void> _fetchTimetable() async {
    final userClass = arguments['class'] as String? ?? 'Default Class';

    for (var day in days) {
      final snapshot = await _firestore
          .collection('timetable')
          .doc(userClass)
          .collection(day)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          for (var doc in snapshot.docs) {
            _daySubjectStatus[day]![doc.id] = doc['isScheduled'] as bool;
          }
        });
      }
    }
  }

  Future<void> _saveTimetable() async {
    final userClass = arguments['class'] as String? ?? 'Default Class';

    try {
      for (var day in days) {
        final daySubjects = _daySubjectStatus[day];
        if (daySubjects != null) {
          for (var subject in daySubjects.keys) {
            await _firestore
                .collection('timetable')
                .doc(userClass)
                .collection(day)
                .doc(subject)
                .set({'isScheduled': daySubjects[subject]});
          }
        }
      }

      Get.snackbar(
        'Success',
        'Timetable saved successfully',
        backgroundColor:
            Colors.green, // You can use any color from your AppColors
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error saving timetable: $e',
        backgroundColor:
            Colors.red, // You can use any color from your AppColors
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userClass = arguments['class'] as String? ?? 'Default Class';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo[800],
        title: Text(
          '$userClass Timetable',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (context, index) {
          String day = days[index];
          return ExpansionTile(
            title: Text(
              day,
              style: const TextStyle(
                  color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
            children: subjects.map((subject) {
              return CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.deepOrange,
                title: Text(
                  subject,
                  style: TextStyle(
                      color: Colors.indigo[800], fontWeight: FontWeight.normal),
                ),
                value: _daySubjectStatus[day]![subject],
                onChanged: (bool? value) {
                  setState(() {
                    _daySubjectStatus[day]![subject] = value ?? false;
                  });
                },
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: 80,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.deepOrange)),
          onPressed: _saveTimetable,
          child: const Text('Save Changes'),
        ),
      ),
    );
  }
}
