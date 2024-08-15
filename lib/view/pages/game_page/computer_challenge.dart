import 'dart:async';
import 'dart:math';

import 'package:colorclash/model_view/provider/game_provider.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/molecule/avatar_image.dart';
import 'package:colorclash/view/organisma/winner_screen.dart';
import 'package:colorclash/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class ComputerChallenge extends StatefulWidget {
  final bool musicStatus;
  final int selectedDifficulty;

  const ComputerChallenge({super.key, required this.musicStatus, required this.selectedDifficulty});

  @override
  State<ComputerChallenge> createState() => _ComputerChallengeState();
}

class _ComputerChallengeState extends State<ComputerChallenge> {
  AudioPlayer? _player;
  String source = "";
  final String sourceTap = SoundConstants().tapSound;
  Duration? duration;
  int player1Color = 0;
  int player2Color = 0;
  String avatarPath = "";
  Timer? timer;
  int countPlay = 1;

  @override
  void initState() {
    Provider.of<GameProvider>(context, listen: false).startTimer();
    int tickDate;
    if (widget.selectedDifficulty == 0) {
      tickDate = Random().nextInt(500 - 100 + 1) + 100;
    } else if (widget.selectedDifficulty == 1) {
      tickDate = Random().nextInt(300 - 80 + 1) + 80;
    } else {
      tickDate = Random().nextInt(200 - 60 + 1) + 60;
    }
    timer = Timer.periodic(Duration(milliseconds: tickDate), (timer) {
      Provider.of<GameProvider>(context, listen: false).playerTwoPress();
    });
    if (widget.musicStatus) {
      startBgmMusic();
    }
    fillData();
    super.initState();
  }

  Future<void> startBgmMusic() async {
    _player = AudioPlayer();
    source = await SharedPreferencesMethod().getSelectedMusicPath();
    duration = await _player!.setAsset(source);
    _player!.setLoopMode(LoopMode.one);
    _player!.play();
  }

  fillData() async {
    player1Color = await SharedPreferencesMethod().getPlayer1Color();
    player2Color = await SharedPreferencesMethod().getPlayer2Color();
    avatarPath = await SharedPreferencesMethod().getPlayerOneImagePath();
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 1));
    if (context.mounted) {
      Provider.of<GameProvider>(context, listen: false).initPlayers(context);
    }
  }

  @override
  void dispose() {
    if(_player != null){
      _player!.dispose();
    }
    if(timer != null){

      timer!.cancel();
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
                      Container(
                        width: double.infinity,
                        height: gameProvider.playerTwo,
                        decoration: BoxDecoration(
                          color: player2Color != 0 ? Color(player2Color) : GameColor().redColor,
                        ),
                        child: Align(
                          alignment: const Alignment(0, 1),
                          child: RotatedBox(
                            quarterTurns: 90,
                            child: Container(
                              margin: EdgeInsets.only(
                                top: ScreenSizeUtil().getCalculateHeight(context, 30),
                              ),
                              child: Text(
                                "${AppLocalizations.of(context)!.translate("player")} 2".toUpperCase(),
                                style: TextFont().alfaRegularMethod(40, GameColor().whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Provider.of<GameProvider>(context, listen: false).playerOnePress();
                        },
                        child: Container(
                          width: double.infinity,
                          height: gameProvider.playerOne,
                          decoration: BoxDecoration(
                            color: player1Color != 0 ? Color(player1Color) : GameColor().orangeColor,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: const Alignment(0, -1),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: ScreenSizeUtil().getCalculateHeight(context, 30),
                                  ),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.translate("player")} 1".toUpperCase(),
                                    style: TextFont().alfaRegularMethod(40, GameColor().whiteColor),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(1, 1),
                                child: AvatarImage(bgColor: GameColor().purpleColor, imagePath: ImageConstants().selectImageIcon, selectedAvatar: avatarPath),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenSizeUtil().getCalculateHeight(context, 40),
                      left: ScreenSizeUtil().getCalculateWith(context, 10),
                      right: ScreenSizeUtil().getCalculateWith(context, 10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<GameProvider>(context, listen: false).initPlayers(context);
                            Provider.of<GameProvider>(context, listen: false).resetTimer();
                            UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const HomePage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: GameColor().whiteColor,
                              borderRadius: BorderRadius.circular(360),
                            ),
                            padding: EdgeInsets.all(
                              ScreenSizeUtil().getCalculateWith(context, 5),
                            ),
                            child: Icon(
                              Icons.close,
                              color: GameColor().blackColor,
                            ),
                          ),
                        ),
                        Text(
                          "${gameProvider.second.floor()} ${AppLocalizations.of(context)!.translate("second")}",
                          style: TextFont().bangersRegularMethod(40, GameColor().whiteColor, fontWeight: FontWeight.w700),
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
                ],
              ),
            ),
            (gameProvider.playerOneWin || gameProvider.playerTwoWin) && gameProvider.second != 0
                ? WinnerScreen(
                    replayTap: () {
                      Provider.of<GameProvider>(context, listen: false).initPlayers(context);
                      Provider.of<GameProvider>(context, listen: false).restartGame();
                      Provider.of<GameProvider>(context, listen: false).resetTimer();
                      Provider.of<GameProvider>(context, listen: false).startTimer();
                      countPlay++;
                      debugPrint("Count: $countPlay");
                    },
                    countPlay: countPlay,
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
