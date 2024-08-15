import 'package:colorclash/model_view/services/admob_services.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/settings_options.dart';
import 'package:colorclash/view/atom/settings_switch.dart';
import 'package:colorclash/view/molecule/app_bar.dart';
import 'package:colorclash/view/pages/home_page.dart';
import 'package:colorclash/view/pages/settings/change_bg.dart';
import 'package:colorclash/view/pages/settings/language.dart';
import 'package:colorclash/view/pages/settings/music_page.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final bool musicStatus;

  const Settings({super.key, required this.musicStatus});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool musicStatus = false;

  @override
  void initState() {
    fillData();

    super.initState();
  }

  fillData() async {
    musicStatus = widget.musicStatus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().purpleColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 58),
        child: GameAppBar(
          title: AppLocalizations.of(context)!.translate("settings"),
          onTap: () {
            UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const HomePage());
          },
        ),
      ),
      body: Stack(
        children: [
          GameBackground(backgroundImage: ImageConstants().backgroundTwo),
          ListView(
            children: [
              SettingsOptions(
                title: AppLocalizations.of(context)!.translate("language"),
                icon: ImageConstants().languageIcon,
                onTap: () {
                  UsefulMethods().navigatorPushMethod(context, const SettingsLanguage());
                },
                arrowIcon: true,
              ),
              /*SettingsOptions(
                title: AppLocalizations.of(context)!.translate("ads_close"),
                icon: ImageConstants().adsIcon,
                onTap: () {

                },
                arrowIcon: true,
              ),*/
              SettingsOptions(
                title: AppLocalizations.of(context)!.translate("changeBG"),
                icon: ImageConstants().colorIcon,
                onTap: () {
                  UsefulMethods().navigatorPushMethod(context, const ChangeBG());
                },
                arrowIcon: true,
              ),
              SettingsOptions(
                title: AppLocalizations.of(context)!.translate("music"),
                icon: ImageConstants().musicIcon,
                onTap: () {
                  UsefulMethods().navigatorPushMethod(context, const MusicPage());
                },
                arrowIcon: true,
              ),
              SettingsSwitch(
                text: AppLocalizations.of(context)!.translate("sound_status"),
                onChanged: (value) async {
                  setState(() {
                    musicStatus = value;
                  });
                  await SharedPreferencesMethod().saveMusicStatus(musicStatus);
                },
                value: musicStatus,
              ),
              AdmobServices().startLargeBannerAd(),
            ],
          ),
        ],
      ),
    );
  }
}
