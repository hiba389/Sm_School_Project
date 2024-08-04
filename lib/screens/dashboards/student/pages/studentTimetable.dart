import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/constant/data.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};
  String? userClass;
  late Future<Map<String, Map<String, bool>>> _timetableFuture;

  @override
  void initState() {
    super.initState();
    userClass = arguments['class'] as String?;
    _timetableFuture = _fetchTimetable();
  }

  Future<Map<String, Map<String, bool>>> _fetchTimetable() async {
    if (userClass == null) return {};

    Map<String, Map<String, bool>> timetable = {};
    for (var day in days) {
      final daySnapshot = await _firestore
          .collection('timetable')
          .doc(userClass)
          .collection(day)
          .get();

      Map<String, bool> subjects = {};
      for (var subjectDoc in daySnapshot.docs) {
        subjects[subjectDoc.id] = subjectDoc.get('isScheduled') ?? false;
      }
      timetable[day] = subjects;
    }

    return timetable;
  }

  @override
  Widget build(BuildContext context) {
    // Determine the available width and height
    final screenSize = MediaQuery.of(context).size;
    final double columnWidth = screenSize.width / (days.length + 1);
    final double rowHeight =
        (screenSize.height - AppBar().preferredSize.height) /
            (subjects.length + 1);

    // Abbreviate the days and subjects
    final abbreviatedDays = {
      'Monday': 'Mon',
      'Tuesday': 'Tue',
      'Wednesday': 'Wed',
      'Thursday': 'Thu',
      'Friday': 'Fri',
      'Saturday': 'Sat',
      'Sunday': 'Sun',
    };
    final abbreviatedSubjects = {
      'Mathematics': 'Maths',
      'Science': 'Sci',
      'EnglishLit': 'Lit',
      'EnglishLang': 'Lang',
      'Urdu': 'Urdu',
      'Islamiat': 'Isl',
      'SST': 'S.ST',
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '$userClass  Weekly Schedule',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilder<Map<String, Map<String, bool>>>(
        future: _timetableFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No timetable data available.'),
            );
          } else {
            final timetableData = snapshot.data!;

            return SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black, width: 2.5),
                    columnWidths: {
                      0: FixedColumnWidth(columnWidth),
                      for (var i = 1; i <= days.length; i++)
                        i: FixedColumnWidth(columnWidth),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                        ),
                        children: [
                          SizedBox(
                            height: rowHeight,
                            child: const Center(
                              child: Text(
                                'Subjects',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          ),
                          ...abbreviatedDays.values
                              .map((day) => SizedBox(
                                    height: rowHeight,
                                    child: Center(
                                      child: Text(
                                        day,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo[800],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                      ...abbreviatedSubjects.keys.map((subject) {
                        return TableRow(
                          children: [
                            SizedBox(
                              height: rowHeight,
                              child: Center(
                                child: Text(
                                  abbreviatedSubjects[subject]!,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo[800],
                                  ),
                                ),
                              ),
                            ),
                            ...abbreviatedDays.keys.map((day) {
                              bool isScheduled =
                                  timetableData[day]?[subject] ?? false;
                              return SizedBox(
                                height: rowHeight,
                                child: Center(
                                  child: Icon(
                                    isScheduled ? Icons.check : Icons.close,
                                    color: isScheduled
                                        ? Colors.green
                                        : Colors.deepOrange,
                                    size: 25.0,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
