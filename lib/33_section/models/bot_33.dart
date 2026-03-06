import 'dart:math';

import 'package:gierkownia2/consts/enums.dart';

class Bot33 {
  Bot33({
    level33 level = level33.easy,
    int actualNumber = 0,
    int finalNumber = 33,
    Random? random,
  })  : type = level,
        actualNumber = actualNumber,
        finalNumber = max(33, finalNumber),
        _random = random ?? Random();

  final Random _random;

  level33 type;
  int actualNumber;
  int finalNumber;

  void configure({
    required level33 level,
    required int finalNumber,
    int actualNumber = 0,
  }) {
    type = level;
    this.finalNumber = max(33, finalNumber);
    this.actualNumber = actualNumber;
  }


  int move(actualNumber) {
    this.actualNumber=actualNumber;
    switch (type) {
      case level33.easy:
        easyBot();
        break;
      case level33.normal:
        normalBot();
        break;
      case level33.hard:
        hardBot();
        break;
    }
    return actualNumber;
  }


  void easyBot() {
    final dodawana = _random.nextInt(3) + 1;
    _applyMove(dodawana);
  }


  void normalBot() {
    final shouldPlayHard = _random.nextInt(100) < 70;
    if (shouldPlayHard) {
      hardBot();
    } else {
      easyBot();
    }
  }

  void hardBot() {
    final endgame = _endgameMove();
    if (endgame != null) {
      _applyMove(endgame);
      return;
    }

    final targetMod = (finalNumber - 1) % 4;
    final currentMod = actualNumber % 4;

    if (targetMod == currentMod) {
      easyBot();
      return;
    }

    int dodanaWartosc;
    if (targetMod < currentMod) {
      dodanaWartosc = 4 - (currentMod - targetMod);
    } else {
      dodanaWartosc = targetMod - currentMod;
    }

    _applyMove(dodanaWartosc);
  }




  int _maxAllowedMove() {
    final remaining = finalNumber - actualNumber;
    return remaining.clamp(0, 3);
  }

  void _applyMove(int value) {
    final maxMove = _maxAllowedMove();
    if (maxMove == 0) {
      return;
    }
    final safeValue = value.clamp(1, maxMove);
    actualNumber += safeValue;
  }


  int? _endgameMove() {
    final remaining = finalNumber - actualNumber;
    if (remaining <= 0 || remaining > 4) {
      return null;
    }

    if (remaining == 1) {
      // Ruch wymuszony – bot niestety przegrywa.
      return 1;
    }

    // Zostaw przeciwnikowi finalNumber - 1.
    return remaining - 1;
  }
}