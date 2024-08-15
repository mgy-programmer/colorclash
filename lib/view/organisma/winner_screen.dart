import 'dart:io';

import 'package:colorclash/model_view/provider/game_provider.dart';
import 'package:colorclash/model_view/services/admob_services.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/text_font.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/game_button.dart';
import 'package:colorclash/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class WinnerScreen extends StatefulWidget {
  final Function() replayTap;
  final String? winnerAvatar;
  final int countPlay;

  const WinnerScreen({super.key, required this.replayTap, this.winnerAvatar, required this.countPlay});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    if (_interstitialAd == null) {
      adLoad();
    }
    super.initState();
  }

  adLoad() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint("*****************************************On dismiss ad");
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
          showAd();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  showAd() async {
    if (context.mounted && _interstitialAd != null && widget.countPlay % 3 == 0) {
      debugPrint("*********************************************inside");
      _interstitialAd?.show();
    } else {
      debugPrint("*********************************************Ad null or context not available");
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, widgets) {
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
                  widget.winnerAvatar != null
                      ? Stack(
                          children: [
                            Align(
                              alignment: const Alignment(0, 0),
                              child: Image.asset(ImageConstants().winnerAvatar),
                            ),
                            Align(
                              alignment: const Alignment(0, 0),
                              child: Container(
                                width: ScreenSizeUtil().getCalculateWith(context, 72),
                                height: ScreenSizeUtil().getCalculateWith(context, 72),
                                margin: EdgeInsets.only(
                                  top: ScreenSizeUtil().getCalculateHeight(context, 13),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Image.file(
                                    File(widget.winnerAvatar!),
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return SvgPicture.asset(ImageConstants().selectImageIcon);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Text(
                    "${AppLocalizations.of(context)!.translate("player")} ${gameProvider.playerOneWin ? "1" : "2"} ${AppLocalizations.of(context)!.translate("won")}",
                    style: TextFont().bangersRegularMethod(48, GameColor().whiteColor),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenSizeUtil().getCalculateHeight(context, 10),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.translate("score"),
                      style: TextFont().bangersRegularMethod(48, GameColor().whiteColor),
                    ),
                  ),
                  Container(
                    width: ScreenSizeUtil().getCalculateWith(context, 200),
                    height: ScreenSizeUtil().getCalculateHeight(context, 50),
                    margin: EdgeInsets.only(
                      top: ScreenSizeUtil().getCalculateHeight(context, 10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: GameColor().winnerBorder, width: 4),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0XFF292D39), Color(0XFF777777)],
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: ScreenSizeUtil().getCalculateWith(context, 5),
                      right: ScreenSizeUtil().getCalculateWith(context, 5),
                      top: ScreenSizeUtil().getCalculateHeight(context, 5),
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: ScreenSizeUtil().getCalculateWith(context, 5),
                          ),
                          child: Image.asset(
                            ImageConstants().award,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "${gameProvider.second.floor()} ${AppLocalizations.of(context)!.translate("second_short")}",
                            style: TextFont().bangersRegularMethod(38, GameColor().whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                        top: ScreenSizeUtil().getCalculateHeight(context, 50),
                      ),
                      child: GameButton(
                        onTap: widget.replayTap,
                        title: AppLocalizations.of(context)!.translate("replay"),
                        bgColor: GameColor().greenColor,
                        shadowColor: GameColor().shadowGreenColor,
                      )),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                    ),
                    child: GameButton(
                      onTap: () async {
                        Provider.of<GameProvider>(context, listen: false).initPlayers(context);
                        Provider.of<GameProvider>(context, listen: false).restartGame();
                        Provider.of<GameProvider>(context, listen: false).resetTimer();
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
    });
  }
}
