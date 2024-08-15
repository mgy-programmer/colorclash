import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  final Function() onTap;
  const BackIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ScreenSizeUtil().getCalculateWith(context, 7)),
        width: ScreenSizeUtil().getCalculateWith(context, 60),
        height: ScreenSizeUtil().getCalculateWith(context, 60),
        child: Center(
          child: Image.asset(
            ImageConstants().backIcon,
          ),
        ),
      ),
    );
  }
}
