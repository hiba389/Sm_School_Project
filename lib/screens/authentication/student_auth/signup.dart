import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/screens/authentication/role_and_forgot/forgot.dart';
import 'package:school_app/screens/authentication/student_auth/login.dart';
import 'package:school_app/services/controllers/textcontrollers.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';
import 'package:school_app/services/functionalities/methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final MyMethods mymethods = MyMethods();
  final MyControllers myControllers = MyControllers();
  final _formKey = GlobalKey<FormState>();
  final FirebaseService firebaseService = FirebaseService();

  void signup() async {
    try {
      firebaseService.studentRegistration(
        mymethods.code,
        myControllers.nameController.text,
        myControllers.fatherNameController.text,
        myControllers.motherNameController.text,
        myControllers.classNumberController.text,
        myControllers.dateController.text,
        myControllers.contactController.text,
        myControllers.emailController.text,
        myControllers.passwordController.text,
      );
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
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        mymethods.genrandom();
      });

      signup();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: ScreenResponse.height(context) * 0.03),
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
                fontWeight: FontWeight.w400),
          ),
          Text(
            "Student Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.indigo[800],
                fontSize: ScreenResponse.height(context) * 0.03,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenResponse.width(context) * .03,
                right: ScreenResponse.width(context) * .03),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Roll Number',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: mymethods.code),
                    decoration: InputDecoration(
                      hintText: 'Roll Number will be generated automatically',
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Name',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Father Name',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.fatherNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Father Name',
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
                        return 'Enter Your Father Name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Mother Name',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.motherNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Mother Name',
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
                        return 'Enter Your Mother Name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Class',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.classNumberController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Class (Class-1)',
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Date Of Birth',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.dateController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Date Of Birth',
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
                        return 'Enter Your Date Of Birth';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Contact Number',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
                          fontSize: ScreenResponse.height(context) * .02,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: ScreenResponse.height(context) * .01),
                  TextFormField(
                    controller: myControllers.contactController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Contact Number',
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
                        return 'Enter Your Contact Number';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
                        left: ScreenResponse.width(context) * .02),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          color: AppColors.mediumNavyColor,
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenResponse.height(context) * .02,
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
                      hintText: 'Password',
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
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      backgroundColor: Colors.deepOrange),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenResponse.height(context) * .024,
                    ),
                  ),
                  onPressed: () {
                    submitForm();
                  }),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: ScreenResponse.height(context) * .01),
                child: TextButton(
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenResponse.height(context) * .02,
                        color: AppColors.mediumNavyColor,
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
                        color: AppColors.mediumNavyColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()));
                    }),
              ),
            ],
          ),
          SizedBox(height: ScreenResponse.height(context) * 0.02)
        ],
      ),
    ));
  }
}
