import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/screens/authentication/teacher_auth/teacher_signin.dart';
import 'package:school_app/services/controllers/textcontrollers.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';

class TeacherSignUp extends StatefulWidget {
  const TeacherSignUp({super.key});

  @override
  State<TeacherSignUp> createState() => _TeacherSignUpState();
}

class _TeacherSignUpState extends State<TeacherSignUp> {
  final MyTeacherControllers myteacherControllers = MyTeacherControllers();
  final formKey = GlobalKey<FormState>();
  final FirebaseService firebaseService = FirebaseService();
  void signupteacher() async {
    try {
      firebaseService.teacherRegistration(
          myteacherControllers.nameeController.text,
          myteacherControllers.classNumberrController.text,
          myteacherControllers.emaiilController.text,
          myteacherControllers.passworrdController.text);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to register: $e',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      signupteacher();
    } else {
      // setState(() {
      //   mymethods.resetCode();
      // });
      Get.snackbar('Error', 'Please Fill All Fields',
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin:
                    EdgeInsets.only(top: ScreenResponse.height(context) * 0.03),
                child: Icon(
                  Icons.school,
                  size: ScreenResponse.height(context) * 0.3,
                  color: Colors.indigo[800],
                ),
              ),
            ),
            Center(
              child: Text(
                "SM SCHOOL SYSTEM",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenResponse.height(context) * 0.03,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Center(
              child: Text(
                "Teacher Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: ScreenResponse.height(context) * 0.03,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 30),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: ScreenResponse.width(context) * .03,
            //       right: ScreenResponse.width(context) * .03),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [

            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                  right: ScreenResponse.width(context) * .02,
                  left: ScreenResponse.width(context) * .03),
              child: Text(
                'Name',
                style: TextStyle(
                    color: AppColors.mediumNavyColor,
                    fontSize: ScreenResponse.height(context) * .02,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: ScreenResponse.height(context) * .01),
            Padding(
              padding: EdgeInsets.only(
                  right: ScreenResponse.width(context) * .02,
                  left: ScreenResponse.width(context) * .02),
              child: TextFormField(
                controller: myteacherControllers.nameeController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Your Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenResponse.height(context) * 0.01,
                  right: ScreenResponse.width(context) * .02,
                  left: ScreenResponse.width(context) * .03),
              child: Text(
                'Class',
                style: TextStyle(
                    color: AppColors.mediumNavyColor,
                    fontSize: ScreenResponse.height(context) * .02,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: ScreenResponse.height(context) * .01),
            Padding(
              padding: EdgeInsets.only(
                  right: ScreenResponse.width(context) * .02,
                  left: ScreenResponse.width(context) * .02),
              child: TextFormField(
                controller: myteacherControllers.classNumberrController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Class  (eg  Class-1)',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Your Class';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenResponse.height(context) * 0.01,
                  left: ScreenResponse.width(context) * .03),
              child: Text(
                'Email',
                style: TextStyle(
                    color: AppColors.mediumNavyColor,
                    fontSize: ScreenResponse.height(context) * .02,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: ScreenResponse.height(context) * .01),
            Padding(
              padding: EdgeInsets.only(
                  right: ScreenResponse.width(context) * .02,
                  left: ScreenResponse.width(context) * .02),
              child: TextFormField(
                controller: myteacherControllers.emaiilController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(height: ScreenResponse.height(context) * .02),
            Padding(
              padding:
                  EdgeInsets.only(left: ScreenResponse.width(context) * .03),
              child: Text(
                'Password',
                style: TextStyle(
                    color: AppColors.mediumNavyColor,
                    fontSize: ScreenResponse.height(context) * .02,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: ScreenResponse.height(context) * .01),
            Padding(
              padding: EdgeInsets.only(
                  right: ScreenResponse.width(context) * .02,
                  left: ScreenResponse.width(context) * .02),
              child: TextFormField(
                obscureText: true,
                controller: myteacherControllers.passworrdController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.blueColor),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Your Password';
                  }
                  if (value.length <= 6) {
                    return 'Password must be at least more than 6 Characters ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenResponse.width(context) * 0.07,
                  top: ScreenResponse.height(context) * 0.05,
                  right: ScreenResponse.width(context) * 0.07),
              child: SizedBox(
                height: ScreenResponse.height(context) * 0.06,
                width: ScreenResponse.width(context) * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        backgroundColor: Colors.deepOrange),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenResponse.height(context) * .024,
                      ),
                    ),
                    onPressed: () {
                      submitForm();
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenResponse.height(context) * .01),
                  child: TextButton(
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenResponse.height(context) * .02,
                          color: Colors.indigo[800],
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          '/forgotPage',
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenResponse.height(context) * .01,
                  ),
                  child: TextButton(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenResponse.height(context) * .02,
                          color: Colors.indigo[800],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const TeacherLogin()));
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
