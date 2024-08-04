import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';

class TeacherHomeWork extends StatefulWidget {
  const TeacherHomeWork({super.key});

  @override
  State<TeacherHomeWork> createState() => _TeacherHomeWorkState();
}

class _TeacherHomeWorkState extends State<TeacherHomeWork> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final userClass = arguments['class'] as String? ?? 'Default Class';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          'Homework Upload',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          DateFormat('dd-MMMM-yyyy').format(pickedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => _uploadHomework(userClass),
              //   child: const Text('Upload'),
              // ),
              SizedBox(
                height: ScreenResponse.height(context) * 0.06,
                width: ScreenResponse.width(context) * 0.9,
                child: ElevatedButton(
                  onPressed: () => _uploadHomework(userClass),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      backgroundColor: Colors.indigo[800]),
                  child: const Text('Upload HomeWork'),
                ),
              ),
              const SizedBox(height: 40),
              const Text('Delete Old HomeWork That was Assigned 7 Days Ago'),
              const SizedBox(height: 10),
              SizedBox(
                height: ScreenResponse.height(context) * 0.06,
                width: ScreenResponse.width(context) * 0.9,
                child: ElevatedButton(
                  onPressed: () => firebaseService.deleteOldHomework(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  child: const Text('Delete Old HomeWork'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _uploadHomework(String userClass) async {
    if (_formKey.currentState!.validate()) {
      final subject = _subjectController.text;
      final description = _descriptionController.text;
      final date = _dateController.text;

      final homeworkData = {
        'subject': subject,
        'description': description,
        'date': date,
        'class': userClass,
      };

      await FirebaseFirestore.instance
          .collection('classes')
          .doc(userClass)
          .collection('homework')
          .add(homeworkData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Homework uploaded successfully')),
      );

      _subjectController.clear();
      _descriptionController.clear();
      _dateController.clear();
      Get.back();
    }
  }
}
