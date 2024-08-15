import 'package:colorclash/model_view/provider/game_provider.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/game_button.dart';
import 'package:colorclash/view/pages/game_page/local_challenge.dart';
import 'package:colorclash/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LetsStartPage extends StatefulWidget {
  final bool musicStatus;

  const LetsStartPage({super.key, required this.musicStatus});

  @override
  State<LetsStartPage> createState() => _LetsStartPageState();
}

class _LetsStartPageState extends State<LetsStartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: GameColor().primaryColor,
      ),
      child: Stack(
        children: [
          GameBackground(backgroundImage: ImageConstants().backgroundTwo),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate("start_title"),
                  style: TextFont().bangersRegularMethod(40, GameColor().whiteColor),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                    top: ScreenSizeUtil().getCalculateHeight(context, 150),
                  ),
                  child: GameButton(
                    onTap: () {
                      UsefulMethods().navigatorPushMethod(
                        context,
                        LocalChallenge(
                          musicStatus: widget.musicStatus,
                        ),
                      );
                    },
                    title: AppLocalizations.of(context)!.translate("start"),
                    bgColor: GameColor().greenColor,
                    shadowColor: GameColor().shadowGreenColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                  ),
                  child: GameButton(
                    onTap: () async {
                      if (context.mounted) UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const HomePage());
                    },
                    title: AppLocalizations.of(context)!.translate("homepage"),
                    bgColor: GameColor().orangeColor,
                    shadowColor: GameColor().shadowOrangeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
