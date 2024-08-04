import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/screens/authentication/role_and_forgot/guestmode.dart';

class FirebaseService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore usercollections = FirebaseFirestore.instance;

  void studentRegistration(
    String rollnumber,
    String namenumber,
    String fathername,
    String mothername,
    String classs,
    String dateofbirth,
    String contactnumber,
    String email,
    String password,
  ) async {
    try {
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      String studentId = authentication.currentUser!.uid;
      await usercollections.collection('students').doc(studentId).set({
        'rollnumber': rollnumber,
        'name': namenumber,
        'fathername': fathername,
        'mothername': mothername,
        'class': classs,
        'dateofbirth': dateofbirth,
        'contactnumber': contactnumber,
        'email': email,
        'password': password,
        'role': 'Student'
      });
      Get.snackbar('Welcome!!', 'Student Registration Successful',
          colorText: Colors.white, backgroundColor: AppColors.blueColor);
      Get.offAllNamed('/student_dashboard_screen', arguments: {
        'name': namenumber,
        'class': classs,
        'role': 'Student',
        'rollnumber': rollnumber,
      });
    } catch (e) {
      Get.snackbar(e.toString(), e.toString());
    }
  }

/////Student login
  void studentlogin(
    String email,
    String password,
  ) async {
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      String studentId = authentication.currentUser!.uid;
      DocumentSnapshot userDoc =
          await usercollections.collection('students').doc(studentId).get();
      String name = userDoc['name'] ?? 'StudentName';
      String classid = userDoc['class'] ?? '';
      String role = userDoc['role'] ?? '';
      String rollnumber = userDoc['rollnumber'] ?? '';
      Get.snackbar('Welcome Back!!', 'Student Login Successful',
          colorText: Colors.white, backgroundColor: AppColors.blueColor);
      Get.offAllNamed('/student_dashboard_screen', arguments: {
        'name': name,
        'class': classid,
        'role': role,
        'rollno': rollnumber,
      });
    } catch (e) {
      print(e);
      Get.snackbar(e.toString(), e.toString());
    }
  }

//////TeacherRegistration
  void teacherRegistration(
    String namenumber,
    String classs,
    String email,
    String password,
  ) async {
    try {
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      String teacherId = authentication.currentUser!.uid;
      await usercollections.collection('teachers').doc(teacherId).set({
        'name': namenumber,
        'class': classs,
        'email': email,
        'password': password,
        'role': 'Teacher'
      });
      Get.snackbar('Welcome!!', 'Teacher Registration Successful',
          colorText: Colors.white, backgroundColor: AppColors.blueColor);
      Get.offAllNamed('/teacher_dashboard_screen', arguments: {
        'name': namenumber,
        'class': classs,
        'role': 'Teacher',
      });
    } catch (e) {
      Get.snackbar(e.toString(), e.toString());
    }
  }

  ////////////////teacher login
  void teacherlogin(
    String email,
    String password,
  ) async {
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      String studentId = authentication.currentUser!.uid;
      DocumentSnapshot userDoc =
          await usercollections.collection('teachers').doc(studentId).get();
      String name = userDoc['name'] ?? 'TeacherName';
      String classid = userDoc['class'] ?? '';
      String role = userDoc['role'] ?? '';

      Get.snackbar('Welcome Back!!', 'Teacher Login Successful',
          colorText: Colors.white, backgroundColor: AppColors.blueColor);
      Get.offAllNamed('/teacher_dashboard_screen', arguments: {
        'name': name,
        'class': classid,
        'role': role,
      });
    } catch (e) {
      print(e);
      Get.snackbar(e.toString(), e.toString());
    }
  }

  //////////////////signout
  void signout() {
    authentication.signOut().then((_) {
      // This block is executed after the sign-out completes
      Get.snackbar(
        'Log Out',
        'You have been Logged Out',
        colorText: Colors.white,
        backgroundColor: AppColors.blueColor,
      );
      Get.offAll(() => const GuestMode());
    }).catchError((e) {
      // This block is executed if an error occurs
      Get.snackbar(
        'Error',
        'Failed to log out: $e',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    });
  }

  //////////////////////////////////////////ResetPassword
  Future<void> resetPassword(String email) async {
    try {
      await authentication.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle errors (e.g., email not found)
      throw Exception('Failed to send reset email: $e');
    }
  }
  //////////////////////Delete Old Homework

  Future<void> deleteOldHomework() async {
    final now = DateTime.now();
    final cutoffDate =
        now.subtract(const Duration(days: 7)); // Calculate cutoff date

    // Format the cutoff date to match the format in Firestore
    final cutoffDateStr = DateFormat('dd-MMMM-yyyy').format(cutoffDate);

    final firestore = FirebaseFirestore.instance;

    // Get the current user ID (assuming you're using Firebase Authentication)
    String studentId = authentication.currentUser!.uid;

    // Get the class ID for the current user (e.g., teacher or student)
    DocumentSnapshot userDoc =
        await firestore.collection('teachers').doc(studentId).get();
    String classid = userDoc['class'] ?? '';

    try {
      // Initialize batch
      final batch = firestore.batch();

      // Query all documents in the homework collection
      final homeworkSnapshot = await firestore
          .collection('classes')
          .doc(classid)
          .collection('homework')
          .get();

      // Iterate through documents and delete those older than cutoffDate
      for (final homeworkDoc in homeworkSnapshot.docs) {
        final data = homeworkDoc.data();
        final dateStr = data['date'] as String;

        // Convert the string date to DateTime
        final homeworkDate = DateFormat('dd-MMMM-yyyy').parse(dateStr);

        // Compare and delete if older than cutoff date
        if (homeworkDate.isBefore(cutoffDate)) {
          batch.delete(homeworkDoc.reference);
        }
      }

      // Commit the batch
      await batch.commit();
      Get.snackbar('Homework', 'Old Homework Deleted');
      Get.back();
      print('Old homework data deleted successfully.');
    } catch (e) {
      print('Error deleting old homework data: $e');
    }
  }
}
