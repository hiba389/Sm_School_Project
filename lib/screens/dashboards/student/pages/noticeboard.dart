import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/services/functionalities/methods.dart';

class NoticeBoardPage extends StatefulWidget {
  const NoticeBoardPage({super.key});

  @override
  _NoticeBoardPageState createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
  late Future<List<String>> announcements;
  final MyMethods methods = MyMethods();

  @override
  void initState() {
    super.initState();
    announcements = methods.fetchNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          'Online Notice Board',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0), // AppBar ke baad gap dene ke liye
            Image.network(
              'https://static.vecteezy.com/system/resources/thumbnails/004/641/880/small/illustration-of-high-school-building-school-building-free-vector.jpg', // Network image ka URL yahan set karein
              height: 350.0, // Image ki height
              width: double.infinity, // Image ko full width dene ke liye
              fit: BoxFit.cover, // Image ko cover mode mein fit karne ke liye
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Agar image load ho gai hai to use dikhao
                } else {
                  return const Center(
                    child:
                        CircularProgressIndicator(), // Loading indicator jab tak image load ho rahi hai
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                      'Failed to load image'), // Agar image load na ho to error message dikhao
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<String>>(
              future: announcements,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available.'));
                } else {
                  var announcements = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenResponse.height(context) * .01,
                        horizontal: ScreenResponse.width(context) * .03),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Is line se GridView scroll nahi karega, SingleChildScrollView se scroll hoga
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ScreenResponse.width(context) * .03,
                        mainAxisSpacing: ScreenResponse.height(context) * .01,
                      ),
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            padding: EdgeInsets.all(
                                ScreenResponse.width(context) * .03),
                            decoration: BoxDecoration(
                              color: [
                                const Color.fromARGB(255, 202, 239, 204),
                                const Color.fromARGB(255, 179, 213, 248),
                                const Color.fromARGB(255, 234, 198, 162),
                                const Color.fromARGB(255, 244, 222, 228),
                                const Color.fromARGB(255, 197, 183, 237),
                                const Color.fromARGB(255, 181, 246, 230),
                              ][index % 6],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                announcements[index],
                                style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * .018,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
