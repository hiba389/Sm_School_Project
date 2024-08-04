import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyDiaryPage extends StatelessWidget {
  const DailyDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final userClass = arguments['class'] as String? ?? 'Default Class';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          'Daily Diary',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          // Centered Gradient Icon below the AppBar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  colors: [
                    Colors.deepOrange,
                    Colors.indigo,
                    Colors.deepOrange,
                    // Colors.deepOrange
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(rect);
              },
              child: const Icon(
                Icons.school,
                size: 200,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getCurrentDayWorkStream(userClass),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text('No diary entries available.'));
                }

                final diaryDocs = snapshot.data!.docs;
                final groupedData = _groupDataByDate(diaryDocs);

                return ListView.builder(
                  itemCount: groupedData.length,
                  itemBuilder: (context, index) {
                    final dateGroup = groupedData[index];
                    final dateStr = dateGroup['date'] as String;
                    final entries =
                        dateGroup['entries'] as List<Map<String, dynamic>>;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Center(
                            child: Text(
                              dateStr,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo[800]),
                            ),
                          ),
                          //  textAlign: TextAlign.center,
                        ),
                        ...entries.map((entry) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepOrange[400]!,
                                  Colors.indigo[800]!,
                                  Colors.deepOrange[400]!,
                                  Colors.indigo[800]!,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (entry['imageUrl'] != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      entry['imageUrl'],
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                const SizedBox(height: 12),
                                Text(
                                  'Subject: ${entry['subject'] ?? 'No Subject'}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  entry['description'] ?? 'No description',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const Divider(color: Colors.white),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _getCurrentDayWorkStream(String userClass) {
    final now = DateTime.now();
    final currentDateStr = DateFormat('dd-MMMM-yyyy').format(now);

    return FirebaseFirestore.instance
        .collection('classes')
        .doc(userClass)
        .collection('homework')
        .where('date', isEqualTo: currentDateStr)
        .orderBy('date', descending: true)
        .snapshots();
  }

  List<Map<String, dynamic>> _groupDataByDate(
      List<QueryDocumentSnapshot> diaryDocs) {
    final combined = diaryDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final dateStr = data['date'] as String;
      return {
        'date': dateStr,
        ...data,
      };
    }).toList();

    final groupedData = <String, List<Map<String, dynamic>>>{};
    for (var entry in combined) {
      final dateStr = entry['date'] as String;
      groupedData.putIfAbsent(dateStr, () => []);
      groupedData[dateStr]!.add(entry);
    }

    return groupedData.entries
        .map((entry) => {'date': entry.key, 'entries': entry.value})
        .toList();
  }
}
