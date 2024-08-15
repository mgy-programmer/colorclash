import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/view/atom/game_button.dart';
import 'package:colorclash/view/molecule/dialog_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorsPickerDialog extends StatelessWidget {
  final Color playerColor;
  final Function(Color) onColorChanged;
  final Function() onTap;

  const ColorsPickerDialog({super.key, required this.playerColor, required this.onColorChanged, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().blackColor.withOpacity(.5),
      body: Center(
        child: Container(
          height: ScreenSizeUtil().getCalculateHeight(context, 500),
          decoration: BoxDecoration(
            color: GameColor().whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.only(
            left: ScreenSizeUtil().getCalculateWith(context, 20),
            right: ScreenSizeUtil().getCalculateWith(context, 20),
          ),
          padding: EdgeInsets.only(
            left: ScreenSizeUtil().getCalculateWith(context, 5),
            right: ScreenSizeUtil().getCalculateWith(context, 5),
          ),
          child: Column(
            children: [
              const DialogTopBar(
                width: 350,
              ),
              ColorPicker(
                pickerColor: playerColor,
                onColorChanged: onColorChanged,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
              ),
              Center(
                child: GameButton(
                  onTap: onTap,
                  title: AppLocalizations.of(context)!.translate("ok"),
                  bgColor: GameColor().greenColor,
                  shadowColor: GameColor().shadowGreenColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
