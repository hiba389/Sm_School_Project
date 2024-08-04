import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constant/colors.dart';

class HomeWorkPage extends StatelessWidget {
  const HomeWorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final userClass = arguments['class'] as String? ?? 'Default Class';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          'HomeWork Records',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Container with a network image
          Container(
            height: 350, // Adjust the height as needed
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50) // Curved bottom corners
                  ),
              image: DecorationImage(
                image: NetworkImage(
                    'https://static.vecteezy.com/system/resources/thumbnails/000/129/877/small_2x/free-education-icons-vector.jpg'), // Replace with your network image URL
                fit: BoxFit.contain,
              ),
            ),
          ),
          // StreamBuilder to show homework records
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('classes')
                  .doc(userClass)
                  .collection('homework')
                  .orderBy('date', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No homework available.'));
                }

                final homeworkDocs = snapshot.data!.docs;
                final groupedData = _groupDataByDate(homeworkDocs);

                return ListView.builder(
                  itemCount: groupedData.length,
                  itemBuilder: (context, index) {
                    final dateGroup = groupedData[index];
                    final date = dateGroup['date'] as DateTime;
                    final entries =
                        dateGroup['entries'] as List<Map<String, dynamic>>;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(
                            _formatDate(date),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[800]),
                          ),
                        ),
                        ...entries.map((entry) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 16.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 218,
                                  162), // Light color for highlighting
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry['subject'] ?? 'No subject',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                const SizedBox(
                                    height:
                                        4.0), // Space between subject and description
                                Text(
                                  entry['description'] ?? 'No description',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const Divider(
                          color: Colors.red,
                          //height: 5,
                        ), // Optional: Add a divider between date groups
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

  List<Map<String, dynamic>> _groupDataByDate(
      List<QueryDocumentSnapshot> homeworkDocs) {
    final combined = homeworkDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final dateStr = data['date'] as String;
      final date = DateFormat('dd-MMMM-yyyy').parse(dateStr);
      return {
        'date': date,
        'subject': data['subject'],
        'description': data['description'],
      };
    }).toList();

    final groupedData = <DateTime, List<Map<String, dynamic>>>{};
    for (var entry in combined) {
      DateTime date =
          DateTime(entry['date'].year, entry['date'].month, entry['date'].day);
      groupedData.putIfAbsent(date, () => []);
      groupedData[date]!.add(entry);
    }

    return groupedData.entries
        .map((entry) => {'date': entry.key, 'entries': entry.value})
        .toList();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }
}
