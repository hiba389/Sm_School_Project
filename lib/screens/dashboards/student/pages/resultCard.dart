import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/Responsivness.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/constant/data.dart';
import 'package:school_app/constant/dimensions.dart';
import 'package:school_app/services/controllers/textcontrollers.dart';
import 'package:school_app/services/functionalities/firebase/firebase_service.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({super.key});

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  final MyControllers myControllers = MyControllers();
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};
  final FirebaseService firebaseService = FirebaseService();
  String? name;
  String? userClass;
  String? role;
  String? rollnumber;
  Map<String, dynamic>? midtermMarks;
  Map<String, dynamic>? finaltermMarks;
  bool isLoading = true;
  String? errorMessage;
  final Map<String, TextEditingController> _totalControllers = {
    'Present': TextEditingController(),
    'Absent': TextEditingController(),
    'Leaves': TextEditingController(),
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = arguments['name'] as String? ?? 'Default Name';
    userClass = arguments['class'] as String? ?? 'Default Class';
    role = arguments['role'] as String? ?? 'Default Role';
    rollnumber = arguments['rollnumber'] as String? ?? 'Default RollNumber';
    _fetchTotalAttendance(); // Fetch total attendance data on initialization
    _fetchMarks();
    _fetchRemarks(); // Fetch remarks data
  }

  @override
  void dispose() {
    for (var controller in _totalControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchMarks() async {
    if (name == null || userClass == null) {
      setState(() {
        errorMessage = 'Missing name or class.';
        isLoading = false;
      });
      return;
    }

    print('Fetching marks for userClass: $userClass and studentName: $name');

    try {
      // Fetch midterm marks
      final midtermDocRef = FirebaseFirestore.instance
          .collection('marks')
          .doc(userClass)
          .collection(name!)
          .doc('midtermmarks');

      final midtermDocSnapshot = await midtermDocRef.get();

      // Fetch final term marks
      final finaltermDocRef = FirebaseFirestore.instance
          .collection('marks')
          .doc(userClass)
          .collection(name!)
          .doc('finalmidterm');

      final finaltermDocSnapshot = await finaltermDocRef.get();

      if (midtermDocSnapshot.exists || finaltermDocSnapshot.exists) {
        setState(() {
          midtermMarks = _processMarks(midtermDocSnapshot.data());
          finaltermMarks = _processMarks(finaltermDocSnapshot.data());
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No marks found for the student.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching marks: $e';
        isLoading = false;
      });
    }
  }

  Map<String, dynamic> _processMarks(Map<String, dynamic>? marks) {
    if (marks == null) {
      // Return a map with subjects initialized to dashes
      return {for (var subject in subjects) subject: '-'};
    }

    // Process the marks and convert missing values to 0, and 0 values to dashes
    return {
      for (var subject in subjects)
        subject: marks.containsKey(subject)
            ? marks[subject] == 0
                ? '-'
                : marks[subject]
            : '0'
    };
  }

  String remarks = 'Loading remarks...';

  Future<void> _fetchRemarks() async {
    if (name == null || userClass == null) {
      setState(() {
        errorMessage = 'Missing name or class.';
        isLoading = false;
      });
      return;
    }

    try {
      final remarksDocRef = FirebaseFirestore.instance
          .collection('marks')
          .doc(userClass!)
          .collection(name!)
          .doc('generalRemarks')
          .get();

      final remarksDocSnapshot = await remarksDocRef;

      if (remarksDocSnapshot.exists) {
        setState(() {
          remarks =
              remarksDocSnapshot.data()?['remarks'] ?? 'No remarks available.';
          isLoading = false;
        });
      } else {
        setState(() {
          remarks = 'No remarks found for the student.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching remarks: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String studentId = firebaseService.authentication.currentUser!.uid;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo[800],
          title: Text(
            "$userClass Report Card",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: ScreenResponse.height(context) * 0.02,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenResponse.width(context) * 0.016,
                        top: ScreenResponse.height(context) * 0.016,
                      ),
                      child: Icon(
                        Icons.school,
                        size: ScreenResponse.height(context) * 0.2,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: Text(
                            "SM School ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: ScreenResponse.height(context) * 0.02,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: ScreenResponse.width(context) * 0.02,
                              ),
                              child: Text(
                                "Aiwan-e-Tijarat Road\nSerai Quarter Karachi\nSindh Pakistan",
                                style: TextStyle(
                                    fontSize:
                                        ScreenResponse.height(context) * 0.018,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.indigo[800]),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Center(
                  child: Text(
                    "PERFORMANCE PROFILE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      fontSize: ScreenResponse.height(context) * 0.015,
                    ),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenResponse.width(context) * 0.03,
                          top: ScreenResponse.height(context) * 0.01),
                      width: ScreenResponse.width(context) * 0.2,
                      height: ScreenResponse.height(context) * 0.09,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://i.pinimg.com/564x/1e/ed/5e/1eed5ef431444e34a4aabb3f7b7f3e73.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenResponse.width(context) * 0.01,
                          top: ScreenResponse.height(context) * 0.01),
                      child: Column(
                        children: [
                          Text(
                            "$name",
                            style: TextStyle(
                                fontSize:
                                    ScreenResponse.height(context) * 0.018,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text("$userClass",
                              style: TextStyle(
                                  fontSize:
                                      ScreenResponse.height(context) * 0.018,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.indigo[800]))
                        ],
                      ),
                    )
                  ],
                ),
                FutureBuilder<DocumentSnapshot>(
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

                      final data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      //  final name = data['name'] ?? 'N/A';
                      final rollNumber = data['rollnumber'] ?? 'N/A';
                      final dateOfBirth = data['dateofbirth'] ?? 'N/A';
                      final contactNumber = data['contactnumber'] ?? 'N/A';
                      final fatherName = data['fathername'] ?? 'N/A';
                      final motherName = data['mothername'] ?? 'N/A';

                      return SingleChildScrollView(
                          child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: rollNumber),
                              decoration: InputDecoration(
                                labelText: 'Roll Number',
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
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: dateOfBirth),
                              decoration: InputDecoration(
                                labelText: 'Date Of Birth',
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
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: contactNumber),
                              decoration: InputDecoration(
                                labelText: 'Contact Number',
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
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: fatherName),
                              decoration: InputDecoration(
                                labelText: 'Father Name',
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
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: motherName),
                              decoration: InputDecoration(
                                labelText: 'Mother Name',
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
                          ),
                        ],
                      ));
                    }),
                SizedBox(
                  height: ScreenResponse.height(context) * 0.05,
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Center(
                  child: Text(
                    "Total Attendance",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                        fontSize: ScreenResponse.height(context) * 0.019),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Present',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Absent',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Leaves',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTotalRow(),
                SizedBox(
                  height: ScreenResponse.height(context) * 0.016,
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Center(
                  child: Text(
                    "ACADMIC PERFORMANCE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      fontSize: ScreenResponse.height(context) * 0.016,
                    ),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(
                  height: ScreenResponse.height(context) * 0.016,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : errorMessage != null
                          ? Center(child: Text(errorMessage!))
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (midtermMarks != null &&
                                      midtermMarks!.isNotEmpty &&
                                      name != null) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'Mid Term Marks',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          _buildMarksTable(midtermMarks!),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                  if (finaltermMarks != null &&
                                      finaltermMarks!.isNotEmpty) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'Final Term Marks',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          _buildMarksTable(finaltermMarks!),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                ),
                SizedBox(
                  height: ScreenResponse.height(context) * 0.016,
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Center(
                  child: Text(
                    "REMARKS BY TEACHER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                        fontSize: ScreenResponse.height(context) * 0.016),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.indigo[800],
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 191, 198, 234)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenResponse.height(context) * 0.016,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            remarks,
                            style: TextStyle(
                                fontSize:
                                    ScreenResponse.height(context) * 0.024),
                          ),
                        ),
                        const SizedBox(
                            // height: 150,
                            )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
              ]),
        ));
  }

  Widget _buildTotalRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        children: [
          _buildTextField(_totalControllers['Present']!),
          _buildTextField(_totalControllers['Absent']!),
          _buildTextField(_totalControllers['Leaves']!),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 192, 209),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
          ),
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              controller: controller,
              readOnly: true,
              enabled: false, // Disable editing
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fetchTotalAttendance() async {
    final doc = await FirebaseFirestore.instance
        .collection('attendance')
        .doc(userClass)
        .collection('students')
        .doc(name)
        .get();

    if (doc.exists) {
      final data = doc.data();
      final totalAttendance = data?['totalAttendance'] as Map<String, dynamic>?;

      if (totalAttendance != null) {
        _totalControllers['Present']!.text =
            (totalAttendance['Present'] as int).toString();
        _totalControllers['Absent']!.text =
            (totalAttendance['Absent'] as int).toString();
        _totalControllers['Leaves']!.text =
            (totalAttendance['Leaves'] as int).toString();
      }
    } else {
      // Handle the case where no data is found
    }
  }

  Widget _buildMarksTable(Map<String, dynamic> marks) {
    return Table(
      border: TableBorder.all(color: Colors.black.withOpacity(0.5), width: 1.0),
      children: marks.entries.map((entry) {
        return TableRow(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entry.value.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
