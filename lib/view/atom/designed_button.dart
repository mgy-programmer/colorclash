import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:flutter/material.dart';

class DesignedButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color shadowColor;
  final double fontSize;
  final double height;
  final double width;

  final Function() onTap;

  const DesignedButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.shadowColor,
    required this.fontSize,
    required this.onTap,
    this.height = 42,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSizeUtil().getCalculateHeight(context, height),
        width: ScreenSizeUtil().getCalculateWith(context, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          border: Border.all(color: GameColor().whiteColor, width: 3.5),
        ),
        child: Container(
          width: ScreenSizeUtil().getCalculateWith(context, 325),
          height: ScreenSizeUtil().getCalculateHeight(context, 45),
          padding: EdgeInsets.only(
            left: ScreenSizeUtil().getCalculateWith(context, 3),
            right: ScreenSizeUtil().getCalculateWith(context, 3),
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 4,
                blurRadius: 0,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title.toUpperCase(),
                style: TextFont().cherryRegularMethod(fontSize, GameColor().whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
