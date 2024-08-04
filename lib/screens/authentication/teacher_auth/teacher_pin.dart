import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:school_app/screens/authentication/teacher_auth/teacher_signin.dart';

class VerificationTeacher extends StatefulWidget {
  const VerificationTeacher({super.key});

  @override
  State<VerificationTeacher> createState() => _VerificationTeacherState();
}

class _VerificationTeacherState extends State<VerificationTeacher> {
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());
  final String storedPin = "1234"; // Stored PIN for verification

  void _verifyPin() {
    String enteredPin =
        _pinControllers.map((controller) => controller.text).join();

    if (enteredPin == storedPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN Verified Successfully!')),
      );
      // Navigate to the TeacherLogin screen on successful verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const TeacherLogin(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect PIN. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Blur Effect
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.pikbest.com/wp/202347/celebrating-teacher-happy-teachers-day-with-a-group-of-three-from-various-subjects-standing-together-world-celebration-vector_10030521.jpg!bw700', // Replace with your image URL
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          // Overlay Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Write your PIN here which provided by the school.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.white
                              : const Color.fromARGB(255, 253, 214, 156),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: TextField(
                            controller: _pinControllers[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            obscureText: false, // Show the number as entered
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              counterText: '', // Remove the counter
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: index.isEven ? Colors.black : Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _verifyPin, // Only verify the PIN here
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Verify PIN',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
