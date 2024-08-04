import 'dart:convert';

class FeeDetail {
  final String academicYear;
  final List<Fee> fees;
  final TotalEstimatedMonthlyFee totalEstimatedMonthlyFee;

  FeeDetail({
    required this.academicYear,
    required this.fees,
    required this.totalEstimatedMonthlyFee,
  });

  factory FeeDetail.fromJson(Map<String, dynamic> json) {
    var feeList = json['fees'] as List;
    List<Fee> feeObjects = feeList.map((i) => Fee.fromJson(i)).toList();

    return FeeDetail(
      academicYear: json['academicYear'],
      fees: feeObjects,
      totalEstimatedMonthlyFee:
          TotalEstimatedMonthlyFee.fromJson(json['totalEstimatedMonthlyFee']),
    );
  }
}

class Fee {
  final String title;
  final String amount;
  final String description;

  Fee({
    required this.title,
    required this.amount,
    required this.description,
  });

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      title: json['title'],
      amount: json['amount'],
      description: json['description'],
    );
  }
}

class TotalEstimatedMonthlyFee {
  final String monthly;
  final String total;

  TotalEstimatedMonthlyFee({
    required this.monthly,
    required this.total,
  });

  factory TotalEstimatedMonthlyFee.fromJson(Map<String, dynamic> json) {
    return TotalEstimatedMonthlyFee(
      monthly: json['monthly'],
      total: json['total'],
    );
  }
}
