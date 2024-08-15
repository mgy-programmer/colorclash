import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/view/atom/designed_button.dart';
import 'package:colorclash/view/molecule/dialog_top_bar.dart';
import 'package:flutter/material.dart';

class QuestionDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function() yesMethod;
  final Function()? noMethod;

  const QuestionDialog({super.key, required this.title, required this.yesMethod, required this.content, this.noMethod});

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
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
                widget.title,
                style: TextFont().alfaRegularMethod(
                  16,
                  GameColor().blackColor,
                ),
                textAlign: TextAlign.center,
              ),
              widget.content != ""
                  ? Text(
                      widget.content,
                      style: TextFont().alfaRegularMethod(
                        16,
                        GameColor().blackColor,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DesignedButton(
                    title: AppLocalizations.of(context)!.translate("yes"),
                    bgColor: GameColor().greenColor,
                    shadowColor: GameColor().shadowGreenColor,
                    fontSize: 20,
                    onTap: widget.yesMethod,
                    width: 100,
                  ),
                  DesignedButton(
                    title: AppLocalizations.of(context)!.translate("no"),
                    bgColor: GameColor().lightPurpleColor,
                    shadowColor: GameColor().darkPurpleColor,
                    fontSize: 20,
                    onTap: widget.noMethod ?? () => Navigator.pop(context),
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
