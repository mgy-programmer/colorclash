import 'dart:async';

import 'package:flutter/cupertino.dart';

class GameProvider extends ChangeNotifier {
  double playerOne = 0;
  double playerTwo = 0;
  double fullScreen = 0;
  bool playerOneWin = false;
  bool playerTwoWin = false;
  Timer? timer;
  int second = 0;

  initPlayers(BuildContext context) {
    fullScreen = MediaQuery.of(context).size.height;
    playerOne = playerTwo = fullScreen / 2;
    notifyListeners();
  }

  playerOnePress() {
    if (playerOne + 100 < fullScreen) {
      playerOne += 10;
      playerTwo -= 10;
    } else {
      playerOneWin = true;
      stopTimer();
    }
    notifyListeners();
  }

  playerTwoPress() {
    if (playerTwo + 100 < fullScreen) {
      playerOne -= 10;
      playerTwo += 10;
    } else {
      playerTwoWin = true;
      stopTimer();
    }
    notifyListeners();
  }

  restartGame() {
    playerOneWin = playerTwoWin = false;
    notifyListeners();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      second++;
      notifyListeners();
    });
  }

  pauseTime(){
    timer!.cancel();
    notifyListeners();
  }

  stopTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  resetTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    second = 0;
    notifyListeners();
  }
}
