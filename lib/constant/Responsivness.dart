import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenResponse {
  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;
}
