import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherExaminationPage extends StatefulWidget {
  const TeacherExaminationPage({super.key});

  @override
  State<TeacherExaminationPage> createState() => _TeacherExaminationPageState();
}

class _TeacherExaminationPageState extends State<TeacherExaminationPage> {
  final List<String> subjects = [
    'Mathematics',
    'Science',
    'EnglishLit',
    'EnglishLang',
    'Urdu',
    'Islamiat',
    'SST'
  ];

  final Map<String, TextEditingController> midTermControllers = {};
  final Map<String, TextEditingController> finalTermControllers = {};
  final TextEditingController _remarksController = TextEditingController();
  bool _isFinalTermEnabled = true; // Boolean to control final term marks
  bool _isMidTermEnabled = true; // Boolean to control mid term marks

  @override
  void initState() {
    super.initState();
    // Initialize the controllers for each subject with initial value of 0
    for (var subject in subjects) {
      midTermControllers[subject] = TextEditingController(text: '0');
      finalTermControllers[subject] = TextEditingController(text: '0');
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed
    for (var controller in midTermControllers.values) {
      controller.dispose();
    }
    for (var controller in finalTermControllers.values) {
      controller.dispose();
    }
    _remarksController.dispose();
    super.dispose();
  }

  bool _validateMarks() {
    bool hasValidMarks = false;
    bool hasMarks = false;

    for (var subject in subjects) {
      final midTermMark = midTermControllers[subject]?.text ?? '';
      final finalTermMark = finalTermControllers[subject]?.text ?? '';

      if (_isMidTermEnabled && !_isValidMark(midTermMark) ||
          (_isFinalTermEnabled && !_isValidMark(finalTermMark))) {
        Get.snackbar('Invalid Input',
            'Marks must be between 0 and 100 and numeric only.',
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }

      if (_isFinalTermEnabled && finalTermMark.isEmpty) {
        Get.snackbar(
            'Missing Input', 'Final term marks cannot be empty when enabled.',
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }

      if (_isMidTermEnabled && midTermMark.isNotEmpty ||
          _isFinalTermEnabled && finalTermMark.isNotEmpty) {
        hasMarks = true;
      }
    }

    if (!hasMarks) {
      Get.snackbar('Missing Input', 'At least one mark must be entered.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    return true;
  }

  bool _isValidMark(String mark) {
    final intValue = int.tryParse(mark);
    return intValue != null && intValue >= 0 && intValue <= 100;
  }

  void _submitMarks() async {
    if (!_validateMarks()) {
      return;
    }

    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final rollnumber =
        arguments['rollnumber'] as String? ?? 'Default rollnumber';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final name = arguments['name'] as String? ?? 'Default name';

    Map<String, int> midTermMarks = {};
    Map<String, int> finalTermMarks = {};
    int totalMidTermMarks = 0;
    int totalFinalTermMarks = 0;
    final generalRemarks = _remarksController.text;

    bool shouldUploadMidTerm = false;
    bool shouldUploadFinalTerm = false;

    for (var subject in subjects) {
      int midTermMark =
          int.tryParse(midTermControllers[subject]?.text ?? '0') ?? 0;
      int finalTermMark =
          int.tryParse(finalTermControllers[subject]?.text ?? '0') ?? 0;
      totalMidTermMarks += midTermMark;
      totalFinalTermMarks += finalTermMark;

      if (_isMidTermEnabled && midTermMark > 0) {
        midTermMarks[subject] = midTermMark;
        shouldUploadMidTerm = true;
      }
      if (_isFinalTermEnabled && finalTermMark > 0) {
        finalTermMarks[subject] = finalTermMark;
        shouldUploadFinalTerm = true;
      }
    }

    try {
      // Save midterm and final term marks to Firestore
      final marksCollectionRef = FirebaseFirestore.instance
          .collection('marks')
          .doc(userClass) // Document for the class
          .collection(name); // Collection for the student's name

      if (shouldUploadMidTerm) {
        await marksCollectionRef.doc('midtermmarks').set(midTermMarks);
      }
      if (shouldUploadFinalTerm) {
        await marksCollectionRef.doc('finalmidterm').set(finalTermMarks);
      }
      await marksCollectionRef.doc('totalMarks').set({
        'totalMidTermMarks': shouldUploadMidTerm ? totalMidTermMarks : 0,
        'totalFinalTermMarks': shouldUploadFinalTerm ? totalFinalTermMarks : 0,
      });
      await marksCollectionRef.doc('generalRemarks').set({
        'remarks': generalRemarks,
      });

      Get.back();
      Get.snackbar('Success', 'Marks and Remarks Uploaded');
      print('Marks and remarks uploaded successfully!');
    } catch (e) {
      print('Error uploading marks: $e');
      Get.snackbar('Error', 'Failed to upload marks. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Widget _buildMarksInputRow(String subject) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              subject,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[800]),
            ),
          ),
          Expanded(
            child: TextField(
              controller: midTermControllers[subject],
              keyboardType: TextInputType.number,
              enabled: _isMidTermEnabled, // Updated here
              decoration: InputDecoration(
                labelText: 'Mid-Term',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: finalTermControllers[subject],
              keyboardType: TextInputType.number,
              enabled: _isFinalTermEnabled,
              decoration: InputDecoration(
                labelText: 'Final-Term',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final rollnumber =
        arguments['rollnumber'] as String? ?? 'Default rollnumber';
    final userClass = arguments['class'] as String? ?? 'Default Class';
    final name = arguments['name'] as String? ?? 'Default name';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '$rollnumber Student $name Marks',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mid Term Marks Enabled:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[800],
                      ),
                    ),
                  ),
                  Switch(
                    value: _isMidTermEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isMidTermEnabled = value;
                        print('Mid Term Enabled: $_isMidTermEnabled');
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Final Term Marks Enabled:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[800],
                      ),
                    ),
                  ),
                  Switch(
                    value: _isFinalTermEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isFinalTermEnabled = value;
                        print('Final Term Enabled: $_isFinalTermEnabled');
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter the marks for each subject:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              const SizedBox(height: 20),
              // Use Column to hold all input rows
              Column(
                children: subjects
                    .map((subject) => _buildMarksInputRow(subject))
                    .toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _remarksController,
                maxLines: 5,
                decoration: InputDecoration(
                  //fillColor: Colors.pink,
                  labelText: 'General Remarks',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 100, right: 0),
                child: ElevatedButton(
                  onPressed: _submitMarks,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Upload Marks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
