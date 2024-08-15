import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/system_config.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/game_button.dart';
import 'package:colorclash/view/organisma/lets_start_page.dart';
import 'package:colorclash/view/pages/game_page/local_challenge.dart';
import 'package:colorclash/view/pages/game_page/searching_player.dart';
import 'package:colorclash/view/pages/settings/settings.dart';
import 'package:colorclash/view/template/how_to_play_dialog.dart';
import 'package:colorclash/view/template/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer player = AudioPlayer();
  final String source = SoundConstants().introPlay;
  Duration? duration;
  bool musicStatus = false;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => QuestionDialog(
            title: AppLocalizations.of(context)!.translate("are_you_sure"),
            content: AppLocalizations.of(context)!.translate("exit_question"),
            yesMethod: () => SystemNavigator.pop(),
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    SystemConfig().systemConfiguration();
    startBgmMusic();
    super.initState();
  }

  void startBgmMusic() async {
    musicStatus = await SharedPreferencesMethod().getMusicStatus();
    if (musicStatus) {
      duration = await player.setAsset(source);
      player.setLoopMode(LoopMode.one);
      player.play();
    }
  }

  stopMusic() async {
    await player.stop();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            GameBackground(backgroundImage: ImageConstants().backgroundThree),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: ScreenSizeUtil().getCalculateHeight(context, 40),
                      right: ScreenSizeUtil().getCalculateWith(context, 10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await stopMusic();
                            if (context.mounted) {
                              UsefulMethods().navigatorPushMethod(
                                context,
                                Settings(
                                  musicStatus: musicStatus,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(ScreenSizeUtil().getCalculateWith(context, 10)),
                            child: SvgPicture.asset(
                              ImageConstants().settingsIcon,
                              width: ScreenSizeUtil().getCalculateWith(context, 36),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 170),
                      top: ScreenSizeUtil().getCalculateHeight(context, 100),
                    ),
                    child: SvgPicture.asset(ImageConstants().namedIcon),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                    ),
                    child: GameButton(
                      title: AppLocalizations.of(context)!.translate("computer"),
                      onTap: () {
                        UsefulMethods().navigatorPushMethod(context, SearchingPlayer(musicStatus: musicStatus));
                      },
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
                        player.stop();
                        if (context.mounted) {
                          UsefulMethods().navigatorPushAndNeverComeBackMethod(
                            context,
                            LetsStartPage(
                              musicStatus: musicStatus,
                            ),
                          );
                        }
                      },
                      bgColor: GameColor().greenColor,
                      shadowColor: GameColor().shadowGreenColor,
                      title: AppLocalizations.of(context)!.translate("1V1"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                    ),
                    child: GameButton(
                      onTap: () {
                        showDialog(context: context, builder: (context) => const HowToPlayDialog());
                      },
                      title: AppLocalizations.of(context)!.translate("how_to_play_button"),
                      bgColor: GameColor().orangeColor,
                      shadowColor: GameColor().shadowOrangeColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
