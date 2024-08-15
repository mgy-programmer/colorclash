import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsOptions extends StatelessWidget {
  final String title;
  final String icon;
  final bool arrowIcon;
  final Function() onTap;

  const SettingsOptions({super.key, required this.title, required this.icon, this.arrowIcon = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
          : Container(),
      leading: SvgPicture.asset(icon),
    );
  }
}
