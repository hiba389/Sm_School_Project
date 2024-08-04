import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentSyllabusPage extends StatefulWidget {
  const StudentSyllabusPage({super.key});

  @override
  State<StudentSyllabusPage> createState() => _StudentSyllabusPageState();
}

class _StudentSyllabusPageState extends State<StudentSyllabusPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<DocumentSnapshot> _syllabusStream;
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};

  String? userClass;

  @override
  void initState() {
    super.initState();

    userClass = arguments['class'] as String? ?? 'Default Class';

    _syllabusStream =
        _firestore.collection('syllabus').doc(userClass).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exam Schedule',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade800,
        centerTitle: true,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.indigo.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange,
              Colors.indigo.shade800,
              Colors.deepOrange
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: _syllabusStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No syllabus data available.'));
            }

            final syllabusDoc = snapshot.data!;
            final syllabusEntries =
                syllabusDoc.get('entries') as List<dynamic>? ?? [];

            if (syllabusEntries.isEmpty) {
              return const Center(
                  child: Text('No syllabus entries available.'));
            }

            final syllabusData = syllabusEntries.map((entry) {
              final data = entry as Map<String, dynamic>;
              return {
                'subject': data['subject'] ?? 'No Subject',
                'details': data['details'] ?? 'No Details',
                'day': data['day'] ?? 'No Day',
                'date': data['date'] ?? 'No Date',
                'time': data['time'] ?? 'No Time',
              };
            }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ...syllabusData.map((subject) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subject['subject']!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange.shade700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Details: ${subject['details']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.indigo.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 16, color: Colors.deepOrange),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Date: ${subject['date']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.indigo.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 16, color: Colors.deepOrange),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Time: ${subject['time']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.indigo.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.event_note,
                                        size: 16, color: Colors.deepOrange),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Day: ${subject['day']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.indigo.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Best of luck for your papers!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
