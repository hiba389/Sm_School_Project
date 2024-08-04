import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_app/model/fee_detail.dart';
import 'package:school_app/model/notice.dart';

class MyMethods {
  String regcode = '';
  final Random random = Random();
  String code = 'Roll Number Will be Generated Automatically';
  final Set<String> generateIds = {};
  void genrandom() {
    String newvalue = '';
    do {
      print('object');

      regcode = (random.nextInt(100) + 1).toString();
      newvalue = regcode;
    } while (generateIds.contains(newvalue));

    code = 'SM-$newvalue';
  }

  Future<FeeDetail> fetchFeeDetail() async {
    final response = await http
        .get(Uri.parse('https://66a8e898e40d3aa6ff59e583.mockapi.io/FeeData'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var feeDetail = FeeDetail.fromJson(jsonData[0]);
      return feeDetail;
    } else {
      throw Exception('Failed to load fee detail');
    }
  }

  Future<List<String>> fetchNotices() async {
    final response = await http.get(
        Uri.parse('https://66a8e898e40d3aa6ff59e583.mockapi.io/NoticeBoard'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      // Assuming the response contains a list of announcements
      var announcements = List<String>.from(jsonData[0]['announcements']);
      return announcements;
    } else {
      throw Exception('Failed to load notices');
    }
  }
}
