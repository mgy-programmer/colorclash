import 'dart:io';

import 'package:colorclash/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UsefulMethods{
  final String sourceIntro = SoundConstants().introPlay;
  final String sourceTap = SoundConstants().tapSound;
  final String sourceGamePlay = SoundConstants().gamePlay;
  Duration? durationIntro;
  Duration? durationTap;
  Duration? durationGamePlay;
  XFile? pickedFile;
  late ImagePicker imagePicker;

  navigatorPushMethod(BuildContext context, Widget page) {
    return Navigator.of(context).push(CupertinoPageRoute(builder: (context) => page));
  }

  navigatorPushAndNeverComeBackMethod(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
  }

  navigatorPushAndThenMethod(BuildContext context, Widget page, Function() function) {
    return Navigator.of(context).push(CupertinoPageRoute(builder: (context) => page)).then(
          (value) {
        function();
      },
    );
  }

  Future<String> getImageFromGallery2(BuildContext context) async {
    XFile? pickedFile;
    if (!(await Permission.storage.isGranted)) {
      await Permission.storage.request();
    }
    try {
      if (await Permission.storage.isGranted) {
        final imagePicker = ImagePicker();
        pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );
        Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
        File file = File('${appDocumentsDirectory.path}/playerOne.${pickedFile?.name.split(".").last}');
        String content = await pickedFile!.readAsString();
        await file.writeAsString(content);
        debugPrint('File saved: ${file.path}');
        return file.path;
      } else {
        await openAppSettings();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return "";
  }

  Future<String> getImageFromGallery(String playerName) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return "";
    }
    final String imagePath = await _saveImageToStorage(image.path, playerName);
    return imagePath;
  }

  Future<String> _saveImageToStorage(String imagePath, String playerName) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String newPath = '$appDocPath/$playerName.${imagePath.split(".").last}';

    await File(imagePath).copy(newPath);

    return newPath;
  }

  void startGamePlayMusic(AudioPlayer audioPlayer) async {
    durationGamePlay = await audioPlayer.setAsset(sourceGamePlay);
    audioPlayer.setLoopMode(LoopMode.one);
    audioPlayer.play();
  }

  void startIntroMusic(AudioPlayer audioPlayer) async {
    durationIntro = await audioPlayer.setAsset(sourceIntro);
    audioPlayer.setLoopMode(LoopMode.one);
    audioPlayer.play();
  }

  tapMusic(AudioPlayer tapPlayer)async{
    durationTap = await tapPlayer.setAsset("assets/audio/$sourceTap");
  }

}