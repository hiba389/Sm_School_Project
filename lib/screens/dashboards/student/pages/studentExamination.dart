import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_app/constant/data.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<String, dynamic>? midtermMarks;
  Map<String, dynamic>? finaltermMarks;
  bool isLoading = true;
  String? errorMessage;
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};
  String? userClass;
  String? name;
  String? role;
  String? rollnumber;

  @override
  void initState() {
    super.initState();
    name = arguments['name'] as String?;
    userClass = arguments['class'] as String?;
    role = arguments['role'] as String?;
    rollnumber = arguments['rollnumber'] as String?;
    _fetchMarks();
  }

  Future<void> _fetchMarks() async {
    if (name == null || userClass == null) {
      setState(() {
        errorMessage = 'Missing name or class.';
        isLoading = false;
      });
      return;
    }

    print('Fetching marks for userClass: $userClass and studentName: $name');

    try {
      // Fetch midterm marks
      final midtermDocRef = FirebaseFirestore.instance
          .collection('marks')
          .doc(userClass)
          .collection(name!)
          .doc('midtermmarks');

      final midtermDocSnapshot = await midtermDocRef.get();

      // Fetch final term marks
      final finaltermDocRef = FirebaseFirestore.instance
          .collection('marks')
          .doc(userClass)
          .collection(name!)
          .doc('finalmidterm');

      final finaltermDocSnapshot = await finaltermDocRef.get();

      if (midtermDocSnapshot.exists || finaltermDocSnapshot.exists) {
        setState(() {
          midtermMarks = _processMarks(midtermDocSnapshot.data());
          finaltermMarks = _processMarks(finaltermDocSnapshot.data());
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No marks found for the student.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching marks: $e';
        isLoading = false;
      });
    }
  }

  Map<String, dynamic> _processMarks(Map<String, dynamic>? marks) {
    if (marks == null) {
      // Return a map with subjects initialized to dashes
      return {for (var subject in subjects) subject: '-'};
    }

    // Process the marks and convert missing values to 0, and 0 values to dashes
    return {
      for (var subject in subjects)
        subject: marks.containsKey(subject)
            ? marks[subject] == 0
                ? '-'
                : marks[subject]
            : '0'
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Exam Marks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text(errorMessage!))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (name != null) ...[
                          Text(
                            'Student Name: $name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (midtermMarks != null &&
                            midtermMarks!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Mid Term Marks',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                _buildMarksTable(midtermMarks!),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                        if (finaltermMarks != null &&
                            finaltermMarks!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Final Term Marks',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildMarksTable(finaltermMarks!),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildMarksTable(Map<String, dynamic> marks) {
    return Table(
      border: TableBorder.all(color: Colors.black.withOpacity(0.5), width: 1.0),
      children: marks.entries.map((entry) {
        return TableRow(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entry.value.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
