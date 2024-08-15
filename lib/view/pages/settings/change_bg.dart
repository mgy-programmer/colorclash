import 'package:colorclash/model_view/services/admob_services.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/molecule/app_bar.dart';
import 'package:colorclash/view/organisma/player_side.dart';
import 'package:colorclash/view/template/game_dialog.dart';
import 'package:colorclash/view/template/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeBG extends StatefulWidget {
  const ChangeBG({super.key});

  @override
  State<ChangeBG> createState() => _ChangeBGState();
}

class _ChangeBGState extends State<ChangeBG> {
  int player1ColorCode = 0;
  int player2ColorCode = 0;
  Color? player1Clr;
  Color? player2Clr;
  String player1ImagePath = "";
  String player2ImagePath = "";
  bool isChanged = false;

  fillData() async {
    player1ColorCode = await SharedPreferencesMethod().getPlayer1Color();
    player1Clr = player1ColorCode != 0 ? Color(player1ColorCode) : Colors.red;
    debugPrint("Player1 Color Code: $player1ColorCode");
    player2ColorCode = await SharedPreferencesMethod().getPlayer2Color();
    player2Clr = player2ColorCode != 0 ? Color(player2ColorCode) : Colors.blue;
    debugPrint("Player2 Color Code: $player2ColorCode");
    player1ImagePath = await SharedPreferencesMethod().getPlayerOneImagePath();
    player2ImagePath = await SharedPreferencesMethod().getPlayerTwoImagePath();
    setState(() {});
  }

  @override
  void initState() {
    fillData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().purpleColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 58),
        child: GameAppBar(
          title: AppLocalizations.of(context)!.translate("background"),
          actions: GestureDetector(
            onTap: () async {
              if (player1ImagePath != "") {
                await SharedPreferencesMethod().savePlayerOneImagePath(player1ImagePath);
              }
              if (player2ImagePath != "") {
                await SharedPreferencesMethod().savePlayerTwoImagePath(player2ImagePath);
              }
              if (player1Clr != null) {
                await SharedPreferencesMethod().savePlayer1Color(player1Clr!.value);
              }
              if (player2Clr != null) {
                await SharedPreferencesMethod().savePlayer2Color(player2Clr!.value);
              }
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) => GameDialog(
                    message: AppLocalizations.of(context)!.translate("saved_info"),
                    imagePath: ImageConstants().checkLargeIcon,
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                right: ScreenSizeUtil().getCalculateWith(context, 10),
              ),
              child: SvgPicture.asset(ImageConstants().checkIcon),
            ),
          ),
          onTap: () async {
            if (isChanged) {
              await showDialog(
                context: context,
                builder: (context) => QuestionDialog(
                  title: AppLocalizations.of(context)!.translate("changed_saved"),
                  yesMethod: () async {
                    debugPrint("Yes");
                    if (player1ImagePath != "") {
                      await SharedPreferencesMethod().savePlayerOneImagePath(player1ImagePath);
                    }
                    if (player2ImagePath != "") {
                      await SharedPreferencesMethod().savePlayerTwoImagePath(player2ImagePath);
                    }
                    if (player1Clr != null) {
                      await SharedPreferencesMethod().savePlayer1Color(player1Clr!.value);
                    }
                    if (player2Clr != null) {
                      await SharedPreferencesMethod().savePlayer2Color(player2Clr!.value);
                    }
                    if (context.mounted) Navigator.pop(context);
                    if (context.mounted) Navigator.pop(context);
                  },
                  content: "",
                  noMethod: () {
                    debugPrint("No");
                    if (context.mounted) Navigator.pop(context);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
              );
            }
            else{
              if (context.mounted) Navigator.pop(context);
            }
          },
        ),
      ),
      bottomNavigationBar: AdmobServices().startBottomBannerAd(),
      body: Stack(
        children: [
          GameBackground(
            backgroundImage: ImageConstants().backgroundTwo,
          ),
          Container(
            padding: EdgeInsets.only(
              top: ScreenSizeUtil().getCalculateHeight(context, 20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerSide(
                  playerName: "${AppLocalizations.of(context)!.translate("player")} 1",
                  playerColor: player1Clr ?? Colors.red,
                  colorOnChanged: (value) {
                    if (!isChanged) isChanged = true;
                    setState(() {
                      player1Clr = value;
                    });
                  },
                  onTap: () async {
                    if (context.mounted) Navigator.pop(context);
                  },
                  selectedAvatarPath: player1ImagePath,
                  onTapAvatar: () async {
                    if (!isChanged) isChanged = true;
                    player1ImagePath = await UsefulMethods().getImageFromGallery("Player1Avatar");
                    if (player1ImagePath != "") {
                      debugPrint("Player1 Path: $player1ImagePath");
                    }
                    setState(() {});
                  },
                ),
                Image.asset(ImageConstants().vsPNG),
                PlayerSide(
                  playerColor: player2Clr ?? Colors.blue,
                  colorOnChanged: (value) {
                    if (!isChanged) isChanged = true;
                    setState(() {
                      player2Clr = value;
                    });
                  },
                  onTap: () async {
                    if (context.mounted) Navigator.pop(context);
                  },
                  selectedAvatarPath: player2ImagePath,
                  onTapAvatar: () async {
                    if (!isChanged) isChanged = true;
                    player2ImagePath = await UsefulMethods().getImageFromGallery("Player2Avatar");
                    if (player2ImagePath != "") {
                      debugPrint("Player2 Path: $player2ImagePath");
                    }
                    setState(() {});
                  },
                  playerName: "${AppLocalizations.of(context)!.translate("player")} 2",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
