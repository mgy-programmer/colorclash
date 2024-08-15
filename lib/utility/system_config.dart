import 'package:flutter/services.dart';

class SystemConfig {
  systemConfiguration({Color topColor = const Color(0XFF9858fe), Color bottomColor = const Color(0XFF9858fe)}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: topColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: bottomColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  fixOrientations() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
