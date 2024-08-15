import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameRadioButton extends StatelessWidget {
  final bool selectedStatus;

  const GameRadioButton({super.key, required this.selectedStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeUtil().getCalculateWith(context, 20),
      height: ScreenSizeUtil().getCalculateWith(context, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        color: GameColor().whiteColor,
        border: Border.all(
          color: GameColor().purpleColor,
          width: 3,
        ),
      ),
      child: selectedStatus
          ? Center(
              child: SvgPicture.asset(ImageConstants().checkIcon),
            )
          : Container(),
    );
  }
}
