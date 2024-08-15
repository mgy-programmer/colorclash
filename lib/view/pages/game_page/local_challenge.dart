import 'package:colorclash/model_view/provider/game_provider.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/molecule/avatar_image.dart';
import 'package:colorclash/view/organisma/lets_start_page.dart';
import 'package:colorclash/view/organisma/winner_screen.dart';
import 'package:colorclash/view/pages/home_page.dart';
import 'package:colorclash/view/template/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class LocalChallenge extends StatefulWidget {
  final bool musicStatus;

  const LocalChallenge({super.key, required this.musicStatus});

  @override
  State<LocalChallenge> createState() => _LocalChallengeState();
}

class _LocalChallengeState extends State<LocalChallenge> with SingleTickerProviderStateMixin {
  AudioPlayer? _player;
  String source = "";
  final String sourceTap = SoundConstants().tapSound;
  Duration? duration;
  int player1Color = 0;
  int player2Color = 0;
  String player1Image = "";
  String player2Image = "";
  int countPlay = 1;

  @override
  void initState() {
    Provider.of<GameProvider>(context, listen: false).startTimer();
    if (widget.musicStatus) {
      startBgmMusic();
    }
    fillData();
    super.initState();
  }

  Future<void> startBgmMusic() async {
    _player = AudioPlayer();
    source = await SharedPreferencesMethod().getSelectedMusicPath();
    debugPrint("SelectedPath: $source");
    duration = await _player!.setAsset(source);
    _player!.setLoopMode(LoopMode.one);
    _player!.play();
  }

  fillData() async {
    player1Color = await SharedPreferencesMethod().getPlayer1Color();
    player2Color = await SharedPreferencesMethod().getPlayer2Color();
    player1Image = await SharedPreferencesMethod().getPlayerOneImagePath();
    player2Image = await SharedPreferencesMethod().getPlayerTwoImagePath();
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 1));
    if (context.mounted) {
      Provider.of<GameProvider>(context, listen: false).initPlayers(context);
    }
  }

  @override
  void dispose() {
    if (_player != null) {
      _player!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, widgets) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Provider.of<GameProvider>(context, listen: false).playerOnePress();
                            },
                            child: Container(
                              width: double.infinity,
                              height: gameProvider.playerOne,
                              decoration: BoxDecoration(
                                color: player1Color != 0 ? Color(player1Color) : GameColor().redColor,
                              ),
                              padding: EdgeInsets.only(
                                top: ScreenSizeUtil().getCalculateHeight(context, 50),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: ScreenSizeUtil().getCalculateHeight(context, 30),
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          "${AppLocalizations.of(context)!.translate("player")} 1",
                                          style: TextFont().alfaRegularMethod(32, GameColor().whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: ScreenSizeUtil().getCalculateWith(context, 15),
                                          ),
                                          child: AvatarImage(bgColor: GameColor().purpleColor, imagePath: ImageConstants().selectImageIcon, selectedAvatar: player1Image),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: ScreenSizeUtil().getCalculateWith(context, 15),
                                          ),
                                          child: Text(
                                            "${gameProvider.second.floor()} ${AppLocalizations.of(context)!.translate("second_short")}",
                                            style: TextFont().bangersRegularMethod(28, GameColor().whiteColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Provider.of<GameProvider>(context, listen: false).playerTwoPress();
                            },
                            child: Container(
                              width: double.infinity,
                              height: gameProvider.playerTwo,
                              decoration: BoxDecoration(
                                color: player2Color != 0 ? Color(player2Color) : GameColor().orangeColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: ScreenSizeUtil().getCalculateWith(context, 15),
                                      bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
                                    ),
                                    child: Text(
                                      "${gameProvider.second.floor()} ${AppLocalizations.of(context)!.translate("second_short")}",
                                      style: TextFont().bangersRegularMethod(28, GameColor().whiteColor),
                                    ),
                                  ),
                                  AvatarImage(bgColor: GameColor().purpleColor, imagePath: ImageConstants().selectImageIcon, selectedAvatar: player2Image),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.only(
                                top: ScreenSizeUtil().getCalculateHeight(context, 30),
                                right: ScreenSizeUtil().getCalculateWith(context, 15),
                                left: ScreenSizeUtil().getCalculateWith(context, 15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Provider.of<GameProvider>(context, listen: false).initPlayers(context);
                                      Provider.of<GameProvider>(context, listen: false).resetTimer();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        ScreenSizeUtil().getCalculateWith(context, 5),
                                      ),
                                      child: SvgPicture.asset(
                                        ImageConstants().closeIcon,
                                        width: ScreenSizeUtil().getCalculateWith(context, 40),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      "${AppLocalizations.of(context)!.translate("player")} 2",
                                      style: TextFont().alfaRegularMethod(32, GameColor().whiteColor),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (_player != null) {
                                        if (_player!.playing) {
                                          await _player!.pause();
                                        } else {
                                          await _player!.play();
                                        }
                                      } else {
                                        await startBgmMusic();
                                      }
                                      setState(() {});
                                    },
                                    child: _player != null && _player!.playing
                                        ? SvgPicture.asset(
                                            ImageConstants().soundOnIcon,
                                            width: ScreenSizeUtil().getCalculateWith(context, 40),
                                          )
                                        : SvgPicture.asset(
                                            ImageConstants().soundOffIcon,
                                            width: ScreenSizeUtil().getCalculateWith(context, 40),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gameProvider.playerOneWin || gameProvider.playerTwoWin
                ? WinnerScreen(
                    replayTap: () {
                      Provider.of<GameProvider>(context, listen: false).initPlayers(context);
                      Provider.of<GameProvider>(context, listen: false).restartGame();
                      Provider.of<GameProvider>(context, listen: false).resetTimer();
                      Provider.of<GameProvider>(context, listen: false).startTimer();
                      countPlay++;
                      debugPrint("Count: $countPlay");
                    },
                    winnerAvatar: gameProvider.playerOneWin ? player1Image : player2Image,
                    countPlay: countPlay,
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
