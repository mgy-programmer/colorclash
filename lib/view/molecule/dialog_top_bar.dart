import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogTopBar extends StatelessWidget {
  final double width;
  const DialogTopBar({super.key, this.width = 260});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: ScreenSizeUtil().getCalculateHeight(context, 25),
            width: ScreenSizeUtil().getCalculateWith(context, width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GameColor().lightPurpleColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: GameColor().lightPurpleColor,
                borderRadius: BorderRadius.circular(360),
                border: Border.all(
                  color: GameColor().whiteColor,
                  width: ScreenSizeUtil().getCalculateWith(context, 5),
                ),
              ),
              padding: EdgeInsets.only(
                left: ScreenSizeUtil().getCalculateWith(context, 7),
                right: ScreenSizeUtil().getCalculateWith(context, 7),
                top: ScreenSizeUtil().getCalculateWith(context, 7),
                bottom: ScreenSizeUtil().getCalculateWith(context, 7),
              ),
              child: SvgPicture.asset(
                ImageConstants().closeDialogIcon,
                width: ScreenSizeUtil().getCalculateWith(context, 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
