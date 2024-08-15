import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/view/molecule/avatar_option.dart';
import 'package:colorclash/view/molecule/color_option.dart';
import 'package:colorclash/view/template/color_picker_dialog.dart';
import 'package:flutter/material.dart';

class PlayerSide extends StatefulWidget {
  final Color playerColor;
  final Function(Color) colorOnChanged;
  final Function() onTap;
  final String selectedAvatarPath;
  final Function() onTapAvatar;
  final String playerName;

  const PlayerSide({super.key, required this.playerColor, required this.colorOnChanged, required this.onTap, required this.selectedAvatarPath, required this.onTapAvatar, required this.playerName});

  @override
  State<PlayerSide> createState() => _PlayerSideState();
}

class _PlayerSideState extends State<PlayerSide> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
          ),
          child: Text(
            widget.playerName.toUpperCase(),
            style: TextFont().alfaRegularMethod(
              36,
              GameColor().whiteColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: ScreenSizeUtil().getCalculateWith(context, 10),
            right: ScreenSizeUtil().getCalculateWith(context, 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColorOption(
                buttonText: AppLocalizations.of(context)!.translate("select_color"),
                bgColor: GameColor().lightRedColor,
                shadowColor: GameColor().darkRedColor,
                selectedColor: widget.playerColor,
                onTap: () async{
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ColorsPickerDialog(
                        playerColor: widget.playerColor,
                        onColorChanged: widget.colorOnChanged,
                        onTap: widget.onTap,
                      );
                    },
                  );
                },
                imagePath: ImageConstants().colorIcon,
              ),
              AvatarOption(
                buttonText: AppLocalizations.of(context)!.translate("select_avatar"),
                bgColor: GameColor().lightPurpleColor,
                shadowColor: GameColor().darkPurpleColor,
                onTap: widget.onTapAvatar,
                imagePath: ImageConstants().selectImageIcon,
                selectedAvatar: widget.selectedAvatarPath,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
