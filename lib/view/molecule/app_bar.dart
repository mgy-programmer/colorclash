import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/view/atom/back_icon.dart';
import 'package:flutter/material.dart';

class GameAppBar extends StatelessWidget {
  final String title;
  final Widget? actions;
  final Function() onTap;

  const GameAppBar({super.key, required this.title, this.actions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeUtil().getCalculateWith(context, 393),
      margin: EdgeInsets.only(
        top: ScreenSizeUtil().getCalculateHeight(context, 30),
      ),
      decoration: BoxDecoration(
        color: GameColor().appBarColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: BackIcon(
              onTap: onTap,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextFont().alfaRegularMethod(
                28,
                GameColor().whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: actions ?? Container(),
          ),
        ],
      ),
    );
  }
}
