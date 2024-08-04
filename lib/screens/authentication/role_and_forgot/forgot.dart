import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';
import 'package:school_app/services/controllers/textcontrollers.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyControllers myControllers = MyControllers();
    final formKey = GlobalKey<FormState>();
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[800],
      ),
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
                  Icons.lock_reset,
                  size: ScreenResponse.height(context) * 0.3,
                  color: Colors.deepOrange,
                ),
              ),
              Text(
                "Reset Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenResponse.height(context) * 0.03,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Enter your email to receive password reset instructions",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: ScreenResponse.height(context) * 0.025,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenResponse.width(context) * .03,
                    right: ScreenResponse.width(context) * .03),
                child: Column(
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
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@student\.com$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email ending with @student.com';
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
                          backgroundColor: Colors.indigo[800]),
                      child: Text(
                        "Send Reset Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenResponse.height(context) * .024,
                        ),
                      ),
                      onPressed: () {
                        firebaseService
                            .resetPassword(
                          myControllers.emailController.text,
                        )
                            .then((_) {
                          Get.back();
                          Get.snackbar(
                              'Successfully Link Send', 'Check your Email',
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              colorText: Colors.white,
                              backgroundColor: Colors.green);
                        }).catchError((error) {
                          Get.snackbar('Error', 'Failed to send reset link',
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              colorText: Colors.white,
                              backgroundColor: Colors.red);
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
