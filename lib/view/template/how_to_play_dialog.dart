import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/view/atom/designed_button.dart';
import 'package:colorclash/view/molecule/dialog_top_bar.dart';
import 'package:flutter/material.dart';

class HowToPlayDialog extends StatefulWidget {
  const HowToPlayDialog({super.key});

  @override
  State<HowToPlayDialog> createState() => _HowToPlayDialogState();
}

class _HowToPlayDialogState extends State<HowToPlayDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().blackColor.withOpacity(.4),
      body: Center(
        child: Container(
          width: ScreenSizeUtil().getCalculateWith(context, 300),
          height: ScreenSizeUtil().getCalculateHeight(context, 300),
          padding: EdgeInsets.only(
            left: ScreenSizeUtil().getCalculateWith(context, 10),
            right: ScreenSizeUtil().getCalculateWith(context, 10),
          ),
          decoration: BoxDecoration(
            color: GameColor().whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const DialogTopBar(),
              Text(
                AppLocalizations.of(context)!.translate("how_to_play"),
                style: TextFont().alfaRegularMethod(
                  16,
                  GameColor().blackColor,
                ),
                textAlign: TextAlign.center,
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
