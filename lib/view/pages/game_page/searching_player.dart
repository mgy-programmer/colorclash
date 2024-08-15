import 'dart:async';
import 'dart:math';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/game_button.dart';
import 'package:colorclash/view/pages/game_page/computer_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchingPlayer extends StatefulWidget {
  final bool musicStatus;

  const SearchingPlayer({super.key, required this.musicStatus});

  @override
  State<SearchingPlayer> createState() => _SearchingPlayerState();
}

class _SearchingPlayerState extends State<SearchingPlayer> with SingleTickerProviderStateMixin {
  bool findIt = true;
  late AnimationController _controller;
  double percentValue = 0;
  late Timer timer;
  int selectedDifficulty = 1;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust the duration as needed
      vsync: this,
    );
    _controller.repeat();
    progress();

    super.initState();
  }

  progress() async {
    int millisecond = Random().nextInt(100);
    timer = Timer.periodic(Duration(milliseconds: millisecond), (timer) {
      setState(() {
        if (percentValue < 200) {
          percentValue++;
        } else {
          timer.cancel();
          findIt = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().purpleColor,
      body: SafeArea(
        child: Stack(
          children: [
            GameBackground(backgroundImage: ImageConstants().backgroundTwo),
            Align(
              alignment: const Alignment(-1, -1),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(
                    left: ScreenSizeUtil().getCalculateWith(context, 20),
                    top: ScreenSizeUtil().getCalculateHeight(context, 20),
                  ),
                  child: SvgPicture.asset(ImageConstants().closeIcon),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 30),
                    ),
                    child: Text(
                      findIt ? AppLocalizations.of(context)!.translate("game_is_Ready") : "${AppLocalizations.of(context)!.translate("searching_players")}...",
                      style: TextFont().bangersRegularMethod(
                        32,
                        GameColor().whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GameButton(
                          title: AppLocalizations.of(context)!.translate("easy"),
                          onTap: () {
                            setState(() {
                              selectedDifficulty = 0;
                            });
                          },
                          bgColor: selectedDifficulty == 0 ? GameColor().shadowGreenColor : GameColor().greenColor,
                          shadowColor: selectedDifficulty == 0 ? GameColor().greenColor : GameColor().shadowGreenColor,
                          width: 100,
                          fontSize: 18,
                        ),
                        GameButton(
                          title: AppLocalizations.of(context)!.translate("normal"),
                          onTap: () {
                            setState(() {
                              selectedDifficulty = 1;
                            });
                          },
                          bgColor: selectedDifficulty == 1 ? GameColor().shadowGreenColor : GameColor().greenColor,
                          shadowColor: selectedDifficulty == 1 ? GameColor().greenColor : GameColor().shadowGreenColor,
                          width: 100,
                          fontSize: 16,
                        ),
                        GameButton(
                          title: AppLocalizations.of(context)!.translate("hard"),
                          onTap: () {
                            setState(() {
                              selectedDifficulty = 2;
                            });
                          },
                          bgColor: selectedDifficulty == 2 ? GameColor().shadowGreenColor : GameColor().greenColor,
                          shadowColor: selectedDifficulty == 2 ? GameColor().greenColor : GameColor().shadowGreenColor,
                          width: 100,
                          fontSize: 18,
                        ),
                      ],
                    ),
                  ),
                  findIt
                      ? Container(
                          margin: EdgeInsets.only(
                            bottom: ScreenSizeUtil().getCalculateHeight(context, 30),
                          ),
                          child: GameButton(
                            onTap: () {
                              if (context.mounted) {
                                UsefulMethods().navigatorPushAndNeverComeBackMethod(
                                  context,
                                  ComputerChallenge(
                                    musicStatus: widget.musicStatus,
                                    selectedDifficulty: selectedDifficulty,
                                  ),
                                );
                              }
                            },
                            title: AppLocalizations.of(context)!.translate("start"),
                            bgColor: GameColor().greenColor,
                            shadowColor: GameColor().shadowGreenColor,
                          ),
                        )
                      : Container(
                          width: ScreenSizeUtil().getCalculateWith(context, 245),
                          height: ScreenSizeUtil().getCalculateHeight(context, 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27),
                            color: GameColor().darkBackgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenSizeUtil().getCalculateWith(context, percentValue),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(27),
                                    bottomLeft: Radius.circular(27),
                                  ),
                                  color: GameColor().lightBlueColor,
                                ),
                              ),
                              RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                                child: SvgPicture.asset(ImageConstants().progressNodeIcon),
                              ),
                            ],
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
