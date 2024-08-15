import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color shadowColor;
  final double fontSize;
  final double width;

  final Function() onTap;

  const GameButton({super.key, required this.title, required this.onTap, required this.bgColor, required this.shadowColor, this.fontSize = 20, this.width = 325});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSizeUtil().getCalculateHeight(context, 48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          border: Border.all(color: GameColor().whiteColor, width: 3.5),
        ),
        child: Container(
          width: ScreenSizeUtil().getCalculateWith(context, width),
          height: ScreenSizeUtil().getCalculateHeight(context, 45),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 2,
                blurRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextFont().alfaRegularMethod(fontSize, GameColor().whiteColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
