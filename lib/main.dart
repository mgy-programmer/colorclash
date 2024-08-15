import 'package:colorclash/model_view/provider/game_provider.dart';
import 'package:colorclash/model_view/provider/language_provider.dart';
import 'package:colorclash/model_view/services/language_localizations.dart';
import 'package:colorclash/model_view/services/shared_preferences_method.dart';
import 'package:colorclash/utility/constants.dart';
import 'package:colorclash/utility/system_config.dart';
import 'package:colorclash/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  String langCode = await SharedPreferencesMethod().getSelectedLanguage();
  SystemConfig().fixOrientations();
  runApp(MyApp(
    langCode: langCode,
  ));
}

class MyApp extends StatelessWidget {
  final String langCode;

  const MyApp({super.key, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(create: (context) => GameProvider()),
        ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(builder: (context, langProvider, widgets) {
        return MaterialApp(
          title: Constants().gameName,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
            Locale('de'),
            Locale('es'),
            Locale('fa'),
            Locale('fr'),
            Locale('hi'),
            Locale('id'),
            Locale('it'),
            Locale('ja'),
            Locale('ko'),
            Locale('my'),
            Locale('pt'),
            Locale('ru'),
            Locale('th'),
            Locale('tr'),
            Locale('zh'),
          ],
          debugShowCheckedModeBanner: false,
          localeResolutionCallback: (locale, supportedLocales) {
            String selectedLang;
            if (langProvider.langCode != "") {
              selectedLang = langProvider.langCode;
            } else {
              selectedLang = langCode;
            }
            for (var supportedLocaleLanguage in supportedLocales) {
              if (supportedLocaleLanguage.languageCode == selectedLang) {
                return supportedLocaleLanguage;
              }
            }
            if (supportedLocales.contains(Locale(locale!.languageCode))) {
              return Locale(locale.languageCode);
            }
            return supportedLocales.first;
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      }),
    );
  }
}
