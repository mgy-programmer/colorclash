import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/view/atom/game_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicOptions extends StatelessWidget {
  final String title;
  final bool played;
  final bool arrowIcon;
  final bool selected;
  final Function() onTap;

  const MusicOptions({super.key, required this.title, required this.played, this.arrowIcon = true, required this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: GameColor().greyColor.withOpacity(.2)),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextFont().cherryRegularMethod(
            18,
            GameColor().whiteColor,
          ),
        ),
        trailing: arrowIcon
            ? Icon(
                Icons.arrow_forward_ios,
                color: GameColor().whiteColor,
                size: 20,
              )
            : GameRadioButton(selectedStatus: selected),
        leading: played
            ? SvgPicture.asset(ImageConstants().playIcon)
            : SvgPicture.asset(ImageConstants().musicIcon),
      ),
    );
  }
}
