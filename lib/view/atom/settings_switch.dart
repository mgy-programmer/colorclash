import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  final String text;
  final Function(bool) onChanged;
  final bool value;
  const SettingsSwitch({super.key, required this.text, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
        left: ScreenSizeUtil().getCalculateWith(context, 20),
        right: ScreenSizeUtil().getCalculateWith(context, 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextFont().cherryRegularMethod(
              18,
              GameColor().whiteColor,
            ),
          ),
          Switch(
            value: value,
            activeColor: GameColor().switchActiveColor,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
