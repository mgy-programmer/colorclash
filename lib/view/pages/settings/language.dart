import 'package:colorclash/main.dart';
import 'package:colorclash/model_view/provider/language_provider.dart';
import 'package:colorclash/model_view/services/admob_services.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/game_color.dart';
import 'package:colorclash/utility/useful_methods.dart';
import 'package:colorclash/view/atom/game_background.dart';
import 'package:colorclash/view/atom/language_option.dart';
import 'package:colorclash/view/molecule/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsLanguage extends StatefulWidget {
  const SettingsLanguage({super.key});

  @override
  State<SettingsLanguage> createState() => _SettingsLanguageState();
}

class _SettingsLanguageState extends State<SettingsLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColor().purpleColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 58),
        child: GameAppBar(
          title: AppLocalizations.of(context)!.translate("language"),
          onTap: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: AdmobServices().startBottomBannerAd(),
      body: Stack(
        children: [
          GameBackground(backgroundImage: ImageConstants().backgroundOne),
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              /*LanguageOption(
                title: AppLocalizations.of(context)!.translate("system_language"),
                imagePath: ImageConstants().en,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("system");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("system");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "system"));
                  }
                },
              ),*/
              LanguageOption(
                title: "English",
                subtitle: "English",
                imagePath: ImageConstants().en,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("en");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("en");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "en"));
                  }
                },
              ),
              LanguageOption(
                title: "Deutsche",
                subtitle: "German",
                imagePath: ImageConstants().de,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("de");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("de");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "de"));
                  }
                },
              ),
              LanguageOption(
                title: "Española",
                subtitle: "Spanish",
                imagePath: ImageConstants().es,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("es");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("es");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "es"));
                  }
                },
              ),
              LanguageOption(
                title: "Française",
                subtitle: "French",
                imagePath: ImageConstants().fr,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("fr");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("fr");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "fr"));
                  }
                },
              ),
              LanguageOption(
                title: "italiano",
                subtitle: "Italian",
                imagePath: ImageConstants().it,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("it");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("it");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "it"));
                  }
                },
              ),
              LanguageOption(
                title: "Português",
                subtitle: "Portugal",
                imagePath: ImageConstants().pt,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("pt");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("pt");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "pt"));
                  }
                },
              ),
              LanguageOption(
                title: "Türkçe",
                subtitle: "Turkish",
                imagePath: ImageConstants().tr,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("tr");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("tr");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "tr"));
                  }
                },
              ),
              LanguageOption(
                title: "Bahasa Melayu",
                subtitle: "Malay",
                imagePath: ImageConstants().my,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("my");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("my");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "my"));
                  }
                },
              ),
              LanguageOption(
                title: "Bahasa Indonesia",
                subtitle: "Indonesian",
                imagePath: ImageConstants().id,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("id");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("id");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "id"));
                  }
                },
              ),
              LanguageOption(
                title: "عربى",
                subtitle: "Arabian",
                imagePath: ImageConstants().ar,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("ar");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("ar");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "ar"));
                  }
                },
              ),
              LanguageOption(
                title: "فارسی",
                subtitle: "Persian",
                imagePath: ImageConstants().fa,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("fa");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("fa");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "fa"));
                  }
                },
              ),
              LanguageOption(
                title: "ไทย",
                subtitle: "Thai",
                imagePath: ImageConstants().th,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("th");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("th");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "th"));
                  }
                },
              ),
              LanguageOption(
                title: "中文",
                subtitle: "Chinese",
                imagePath: ImageConstants().zh,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("zh");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("zh");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "zh"));
                  }
                },
              ),
              LanguageOption(
                title: "हिन्दी",
                subtitle: "Hindi",
                imagePath: ImageConstants().hi,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("hi");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("hi");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "hi"));
                  }
                },
              ),
              LanguageOption(
                title: "日本人",
                subtitle: "Japanese",
                imagePath: ImageConstants().ja,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("ja");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("ja");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "ja"));
                  }
                },
              ),
              LanguageOption(
                title: "한국어",
                subtitle: "Korean",
                imagePath: ImageConstants().ko,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("ko");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("ko");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "ko"));
                  }
                },
              ),
              LanguageOption(
                title: "русский",
                subtitle: "Russian",
                imagePath: ImageConstants().ru,
                onTap: () async {
                  await SharedPreferencesMethod().saveSelectedLanguage("ru");
                  if (context.mounted) {
                    Provider.of<LanguageProvider>(context, listen: false).setLanguage("ru");
                    UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const MyApp(langCode: "ru"));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
