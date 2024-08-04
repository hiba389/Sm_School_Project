import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeacherAttendance extends StatefulWidget {
  const TeacherAttendance({super.key});

  @override
  State<TeacherAttendance> createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends State<TeacherAttendance> {
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};
  final Map<String, Map<String, TextEditingController>> _controllers = {};
  final Map<String, bool> _monthStates = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      final month = DateFormat('MMMM').format(DateTime(0, i + 1));
      _controllers[month] = {
        'Present': TextEditingController(text: '0'),
        'Absent': TextEditingController(text: '0'),
        'Leaves': TextEditingController(text: '0'),
      };
      _monthStates[month] = false;
    }
  }

  @override
  void dispose() {
    _controllers.forEach((month, controllers) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rollnumber =
        arguments['rollnumber'] as String? ?? 'Default rollnumber';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final name = arguments['name'] as String? ?? 'Default name';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: Text(
          'Attendance Form - $name',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 2, right: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'Present',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Absent',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Leaves',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  final month =
                      DateFormat('MMMM').format(DateTime(0, index + 1));

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          month,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[800]),
                        ),
                        const SizedBox(height: 8),
                        Switch(
                          value: _monthStates[month]!,
                          activeColor: Colors.deepOrange,
                          onChanged: (value) {
                            setState(() {
                              _monthStates[month] = value;
                            });
                          },
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildTextField(month, 'Present'),
                              const SizedBox(width: 8),
                              _buildTextField(month, 'Absent'),
                              const SizedBox(width: 8),
                              _buildTextField(month, 'Leaves'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _uploadAttendance();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Upload Attendance Progress'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String month, String field) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 208, 222),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.indigo),
        ),
        child: TextField(
          controller: _controllers[month]![field],
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          enabled: _monthStates[month]!,
          decoration: InputDecoration(
            labelText: field,
            labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(12.0),
          ),
        ),
      ),
    );
  }

  void _uploadAttendance() async {
    final rollnumber =
        arguments['rollnumber'] as String? ?? 'Default rollnumber';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final name = arguments['name'] as String? ?? 'Default name';

    final attendanceData = {
      'Present': 0,
      'Absent': 0,
      'Leaves': 0,
    };

    for (var month in _controllers.keys) {
      if (_monthStates[month]!) {
        final present =
            int.tryParse(_controllers[month]!['Present']!.text) ?? 0;
        final absent = int.tryParse(_controllers[month]!['Absent']!.text) ?? 0;
        final leaves = int.tryParse(_controllers[month]!['Leaves']!.text) ?? 0;

        attendanceData['Present'] = attendanceData['Present']! + present;
        attendanceData['Absent'] = attendanceData['Absent']! + absent;
        attendanceData['Leaves'] = attendanceData['Leaves']! + leaves;

        await FirebaseFirestore.instance
            .collection('attendance')
            .doc(userClass) // Document based on the class ID
            .collection('students')
            .doc(name) // Document based on the student's name
            .collection('months')
            .doc(month)
            .set({
          'Present': present,
          'Absent': absent,
          'Leaves': leaves,
        }, SetOptions(merge: true));
      }
    }

    await FirebaseFirestore.instance
        .collection('attendance')
        .doc(userClass)
        .collection('students')
        .doc(name)
        .set({
      'totalAttendance': attendanceData,
    }, SetOptions(merge: true));

    Get.snackbar('Success', 'Attendance data uploaded successfully');
  }
}
