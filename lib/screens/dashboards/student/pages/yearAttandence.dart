import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class YearAttandencePage extends StatefulWidget {
  const YearAttandencePage({super.key});

  @override
  State<YearAttandencePage> createState() => _YearAttandencePageState();
}

class _YearAttandencePageState extends State<YearAttandencePage> {
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};
  final Map<String, Map<String, TextEditingController>> _controllers = {};

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
    }
    _fetchAttendance(); // Fetch attendance data on initialization
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
          '$name Attendance',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Spacer(flex: 2),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Present',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Absent',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Leaves',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              ],
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
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            month,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                        _buildTextField(month, 'Present'),
                        const SizedBox(width: 8),
                        _buildTextField(month, 'Absent'),
                        const SizedBox(width: 8),
                        _buildTextField(month, 'Leaves'),
                      ],
                    ),
                  );
                },
              ),
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
          color: const Color.fromARGB(255, 253, 218, 229),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.indigo),
        ),
        child: TextField(
          controller: _controllers[month]![field],
          style: const TextStyle(color: Colors.black, fontSize: 16),
          keyboardType: TextInputType.number,
          enabled: false, // Disable text field
          decoration: InputDecoration(
            labelText: field,
            labelStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(12.0),
          ),
        ),
      ),
    );
  }

  void _fetchAttendance() async {
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final name = arguments['name'] as String? ?? 'Default name';

    for (var month in _controllers.keys) {
      final doc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(userClass)
          .collection('students')
          .doc(name)
          .collection('months')
          .doc(month)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _controllers[month]!['Present']!.text =
            (data['Present'] as int).toString();
        _controllers[month]!['Absent']!.text =
            (data['Absent'] as int).toString();
        _controllers[month]!['Leaves']!.text =
            (data['Leaves'] as int).toString();
      } else {
        // Handle the case where no data is found for the month
      }
    }
  }
}
