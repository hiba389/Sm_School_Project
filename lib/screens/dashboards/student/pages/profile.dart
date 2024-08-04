import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    String studentId = firebaseService.authentication.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: firebaseService.usercollections
            .collection('students')
            .doc(studentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No data available.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final name = data['name'] ?? 'N/A';
          final rollNumber = data['rollnumber'] ?? 'N/A';
          final dateOfBirth = data['dateofbirth'] ?? 'N/A';
          final contactNumber = data['contactnumber'] ?? 'N/A';
          final fatherName = data['fathername'] ?? 'N/A';
          final motherName = data['mothername'] ?? 'N/A';

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ScreenResponse.height(context) * .3,
                  width: ScreenResponse.width(context) * 1,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(40)),
                    color: Colors.indigo[800],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Container(
                          height: ScreenResponse.height(context) * 0.1,
                          width: ScreenResponse.width(context) * 0.2,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTh0aS_14g3C0K9lbVOufv-0Z3nqlfiuCrYJJ7jRcfI1-HudYY1cDUo-0s5I7G-lfJpxcY&usqp=CAU'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ScreenResponse.height(context) * 0.01,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize:
                                    ScreenResponse.height(context) * 0.025,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                          Text(
                            "${data['class'] ?? 'N/A'}",
                            style: TextStyle(
                                fontSize:
                                    ScreenResponse.height(context) * 0.025,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellowColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenResponse.height(context) * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenResponse.width(context) * 0.02,
                      right: ScreenResponse.width(context) * 0.02,
                      top: ScreenResponse.height(context) * 0.02,
                      bottom: ScreenResponse.height(context) * 0.02),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: TextEditingController(text: rollNumber),
                        decoration: InputDecoration(
                          labelText: 'Roll Number',
                          labelStyle: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenResponse.height(context) * 0.02),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenResponse.height(context) * 0.02,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: dateOfBirth),
                        decoration: InputDecoration(
                          labelText: 'Date Of Birth',
                          labelStyle: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenResponse.height(context) * 0.02),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenResponse.height(context) * 0.02,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: contactNumber),
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                          labelStyle: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenResponse.height(context) * 0.02),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenResponse.height(context) * 0.02,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: motherName),
                        decoration: InputDecoration(
                          labelText: 'Mother Name',
                          labelStyle: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenResponse.height(context) * 0.02),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenResponse.height(context) * 0.02,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: fatherName),
                        decoration: InputDecoration(
                          labelText: 'Father Name',
                          labelStyle: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenResponse.height(context) * 0.02),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 2, color: AppColors.blueColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenResponse.height(context) * 0.02,
                      ),
                      SizedBox(
                        height: ScreenResponse.height(context) * 0.06,
                        width: ScreenResponse.width(context) * 0.9,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            child: Text(
                              "Contact School To Update Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenResponse.height(context) * .018,
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
