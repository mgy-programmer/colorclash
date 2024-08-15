import 'package:flutter/material.dart';

class ScreenSizeUtil {
  late double height;
  late double width;

  init(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  getCalculateHeight(BuildContext context, double calculateHeight) {
    double value = 0;
    init(context);
    value = (calculateHeight * height) / 840;
    return value;
  }

  getCalculateWith(BuildContext context, double calculateWidth) {
    double value = 0;
    init(context);
    value = (calculateWidth * width) / 390;
    return value;
  }
}