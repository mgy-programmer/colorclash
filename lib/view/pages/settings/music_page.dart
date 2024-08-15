import 'package:colorclash/model_view/services/admob_services.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/music_options.dart';
import 'package:colorclash/view/molecule/app_bar.dart';
import 'package:colorclash/view/template/game_dialog.dart';
import 'package:colorclash/view/template/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AudioPlayer _player = AudioPlayer();
  Duration? duration;
  List<String> musicPath = [
    SoundConstants().background_1,
    SoundConstants().background_2,
    SoundConstants().background_3,
    SoundConstants().background_4,
    SoundConstants().background_5,
    SoundConstants().background_6,
    SoundConstants().background_7,
    SoundConstants().background_8,
    SoundConstants().background_9,
    SoundConstants().background_10,
  ];

  String selectedMusic = "";
  bool isChanged = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    selectedMusic = await SharedPreferencesMethod().getSelectedMusicPath();
    setState(() {});
  }

  void startBgmMusic() async {
    duration = await _player.setAsset(selectedMusic);
    _player.setLoopMode(LoopMode.one);
    _player.play();
    setState(() {});
  }

  stopMusic() async {
    _player.stop();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().purpleColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 58),
        child: GameAppBar(
          title: AppLocalizations.of(context)!.translate("music"),
          actions: GestureDetector(
            onTap: () async {
              if (selectedMusic != "") {
                await SharedPreferencesMethod().saveSelectedMusicPath(selectedMusic);
              }
              if (context.mounted) {
                await showDialog(
                  context: context,
                  builder: (context) => GameDialog(
                    message: AppLocalizations.of(context)!.translate("saved_info"),
                    imagePath: ImageConstants().checkLargeIcon,
                  ),
                );
              }
              if (context.mounted) {
                Navigator.pop(context);
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
                    await SharedPreferencesMethod().saveSelectedMusicPath(selectedMusic);
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
          GameBackground(backgroundImage: ImageConstants().backgroundOne),
          ListView.builder(
            itemCount: musicPath.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MusicOptions(
                title: "${index + 1}. ${AppLocalizations.of(context)!.translate("music")}",
                played: musicPath[index] == selectedMusic && _player.playing ? true : false,
                onTap: () {
                  isChanged = true;
                  if (selectedMusic == musicPath[index]) {
                    if (_player.playing) {
                      stopMusic();
                    } else {
                      startBgmMusic();
                    }
                  } else {
                    selectedMusic = musicPath[index];
                    startBgmMusic();
                  }
                  setState(() {});
                },
                arrowIcon: false,
                selected: musicPath[index] == selectedMusic ? true : false,
              );
            },
          ),
        ],
      ),
    );
  }
}

/*
MusicOptions(
  title: AppLocalizations.of(context)!.translate("select_music"),
  icon: "",
  onTap: () {},
  arrowIcon: true,
),
*/
