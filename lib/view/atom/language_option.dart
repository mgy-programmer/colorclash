import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Function() onTap;

  const LanguageOption({super.key, required this.title, required this.onTap, this.subtitle = "", required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextFont().cherryRegularMethod(18, GameColor().whiteColor),
      ),
      subtitle: Text(
        subtitle,
        style: TextFont().cherryRegularMethod(17, GameColor().whiteColor),
      ),
      leading: SvgPicture.asset(imagePath),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: GameColor().whiteColor,
        size: ScreenSizeUtil().getCalculateWith(context, 20),
      ),
      onTap: onTap,
    );
  }
}
