import 'package:colorclash/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMethod {
  late SharedPreferences sharedPreferences;
  double? onlineScore;
  double? offlineScore;
  String langCode = "";
  String playerOnePath = "";
  String playerTwoPath = "";
  String selectedMusicPath = "";
  int player1Color = 0;
  int player2Color = 0;
  bool musicStatus = false;

  //Language

  saveSelectedLanguage(String lngCode) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('langCode', lngCode);
  }

  getSelectedLanguage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    langCode = sharedPreferences.getString('langCode') ?? "";
    return langCode;
  }

  //ImagePath

  savePlayerOneImagePath(String selectedProfile) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('playerOnePath', selectedProfile);
  }

  getPlayerOneImagePath() async {
    sharedPreferences = await SharedPreferences.getInstance();
    playerOnePath = sharedPreferences.getString('playerOnePath') ?? "";
    return playerOnePath;
  }

  savePlayerTwoImagePath(String selectedProfile) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('playerTwoPath', selectedProfile);
  }

  getPlayerTwoImagePath() async {
    sharedPreferences = await SharedPreferences.getInstance();
    playerTwoPath = sharedPreferences.getString('playerTwoPath') ?? "";
    return playerTwoPath;
  }

  //Music

  saveMusicStatus(bool musicStatus) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('musicStatus', musicStatus);
  }

  getMusicStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    musicStatus = sharedPreferences.getBool('musicStatus') ?? true;
    return musicStatus;
  }

  saveSelectedMusicPath(String path) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('selectedMusicPath', path);
  }

  getSelectedMusicPath() async {
    sharedPreferences = await SharedPreferences.getInstance();
    selectedMusicPath = sharedPreferences.getString('selectedMusicPath') ?? "";
    return selectedMusicPath != "" ? selectedMusicPath : SoundConstants().gamePlay;
  }

  //Color

  savePlayer1Color(int player1Color) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('player1Color', player1Color);
  }

  getPlayer1Color() async {
    sharedPreferences = await SharedPreferences.getInstance();
    player1Color = sharedPreferences.getInt('player1Color') ?? 0;
    return player1Color;
  }

  savePlayer2Color(int player2Color) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('player2Color', player2Color);
  }

  getPlayer2Color() async {
    sharedPreferences = await SharedPreferences.getInstance();
    player2Color = sharedPreferences.getInt('player2Color') ?? 0;
    return player2Color;
  }

  //Score

  getOnlineScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    onlineScore = sharedPreferences.getDouble("onlineScore") ?? 0;
    return onlineScore;
  }

  setOnlineScore(double onlineScore) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble("onlineScore", onlineScore);
  }

  getOfflineScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    offlineScore = sharedPreferences.getDouble("offlineScore") ?? 0;
    return offlineScore;
  }

  setOfflineScore(double offlineScore) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble("offlineScore", offlineScore);
  }
}
