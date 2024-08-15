import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/view/atom/designed_button.dart';
import 'package:colorclash/view/molecule/dialog_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameDialog extends StatelessWidget {
  final String message;
  final String imagePath;
  const GameDialog({super.key, required this.message, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().blackColor.withOpacity(.4),
      body: Center(
        child: Container(
          width: ScreenSizeUtil().getCalculateWith(context, 300),
          height: ScreenSizeUtil().getCalculateHeight(context, 300),
          decoration: BoxDecoration(
            color: GameColor().whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 20),
                ),
                child: const DialogTopBar(),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 20),
                  bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
                ),
                child: SvgPicture.asset(
                  imagePath,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
                ),
                child: Text(
                  message,
                  style: TextFont().alfaRegularMethod(
                    16,
                    GameColor().blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              DesignedButton(
                title: AppLocalizations.of(context)!.translate("ok"),
                bgColor: GameColor().lightPurpleColor,
                shadowColor: GameColor().darkPurpleColor,
                fontSize: 20,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
