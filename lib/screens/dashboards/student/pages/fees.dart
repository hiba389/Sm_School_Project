// import 'package:flutter/material.dart';
// import 'package:school_app/constant/Responsivness.dart';
// import 'package:school_app/constant/colors.dart';

// class SchoolFeesPage extends StatelessWidget {
//   const SchoolFeesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.blueColor,
//         centerTitle: true,
//         title: const Text(
//           'School Fees Details',
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Academic Year: 2024-2025',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildFeeSection(
//               title: '1. Admission Fee',
//               amount: 'PKR 10,000',
//               description: 'One-time payment at the time of admission.',
//             ),
//             _buildFeeSection(
//               title: '2. Examination Fee',
//               amount: 'Term 1: PKR 1,500\nTerm 2: PKR 1,500',
//               description: 'Paid per term.',
//             ),
//             _buildFeeSection(
//               title: '3. Activity Fee',
//               amount: 'PKR 2,000 per annum',
//               description: 'For sports and cultural activities.',
//             ),
//             _buildFeeSection(
//               title: '4. Monthly Tuition Fee',
//               amount: 'PKR 3,000',
//               description: 'Paid monthly.',
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Total Estimated Monthly Fee:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Monthly: PKR 3,000',
//               style: TextStyle(fontSize: 16),
//             ),
//             const Text(
//               'Total (Including Admission, Examination, and Activity Fee): PKR 18,000 (assuming 6 months of schooling, plus one-time fees)',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeeSection({
//     required String title,
//     required String amount,
//     required String description,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         padding: const EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: Colors.blue[100],
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 23,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               'Amount: $amount',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               'Description: $description',
//               style: const TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:school_app/constant/colors.dart';
import 'package:school_app/model/fee_detail.dart';
import 'package:school_app/services/functionalities/methods.dart';

class SchoolFeesPage extends StatefulWidget {
  const SchoolFeesPage({super.key});

  @override
  State<SchoolFeesPage> createState() => _SchoolFeesPageState();
}

class _SchoolFeesPageState extends State<SchoolFeesPage> {
  late Future<FeeDetail> futureFeeDetail;
  final MyMethods methods = MyMethods();
  @override
  void initState() {
    super.initState();
    futureFeeDetail = methods.fetchFeeDetail();
  }

  Future<void> _refreshData() async {
    setState(() {
      futureFeeDetail = methods.fetchFeeDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: const Text(
          'School Fees Details',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<FeeDetail>(
          future: futureFeeDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              FeeDetail feeDetail = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic Year: ${feeDetail.academicYear}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[800]),
                      ),
                      const SizedBox(height: 10),
                      ...feeDetail.fees.map((fee) {
                        return _buildFeeSection(
                          title: fee.title,
                          amount: fee.amount,
                          description: fee.description,
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      const Text(
                        'Total Estimated Monthly Fee:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Monthly: ${feeDetail.totalEstimatedMonthlyFee.monthly}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.indigo[800],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total (Including Admission, Examination, and Activity Fee): ${feeDetail.totalEstimatedMonthlyFee.total}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.indigo[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildFeeSection({
    required String title,
    required String amount,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.45),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 23,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Amount: $amount',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.indigo[800],
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
