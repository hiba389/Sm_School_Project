import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/screens/authentication/role_and_forgot/forgot.dart';
import 'package:school_app/screens/authentication/student_auth/signup.dart';
import 'package:school_app/services/controllers/textcontrollers.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';
import 'package:school_app/services/functionalities/methods.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyMethods mymethods = MyMethods();
    final MyControllers myControllers = MyControllers();
    final formKey = GlobalKey<FormState>();
    final FirebaseService firebaseService = FirebaseService();
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: ScreenResponse.height(context) * 0.03),
              child: Icon(
                Icons.school,
                size: ScreenResponse.height(context) * 0.3,
                color: Colors.indigo[800],
              ),
            ),
            Text(
              "SM SCHOOL SYSTEM",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenResponse.height(context) * 0.03,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "Student Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.indigo[600],
                  fontSize: ScreenResponse.height(context) * 0.03,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenResponse.width(context) * .03,
                  right: ScreenResponse.width(context) * .03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.indigo[800],
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.emailController,
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
                  SizedBox(height: ScreenResponse.height(context) * .02),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    obscureText: true,
                    controller: myControllers.passwordController,
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
                ],
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
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenResponse.height(context) * .024,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        firebaseService.studentlogin(
                          myControllers.emailController.text,
                          myControllers.passwordController.text,
                        );
                      } else {
                        Get.snackbar('Error', 'Please Fill All Fields',
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            colorText: Colors.white,
                            backgroundColor: Colors.red);
                      }
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
                        "Sign Up",
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
                                    const SignUpPage()));
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
