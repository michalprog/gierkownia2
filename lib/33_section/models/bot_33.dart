import 'dart:math';

import 'package:gierkownia2/consts/enums.dart';

class Bot33 {
  Bot33({required this.type});

  final level33 type;
  final Random _random = Random();

  int chooseMove({required int actualNumber, required int finalNumber}) {
    final legalMoves = _legalMoves(actualNumber: actualNumber, finalNumber: finalNumber);
    if (legalMoves.isEmpty) {
      return 0;
    }

    switch (type) {
      case level33.easy:
        return legalMoves[_random.nextInt(legalMoves.length)];
      case level33.normal:
        return _normalMove(legalMoves, actualNumber, finalNumber);
      case level33.hard:
        return _hardMove(legalMoves, actualNumber, finalNumber);
    }
  }

  List<int> _legalMoves({required int actualNumber, required int finalNumber}) {
    return [1, 2, 3]
        .where((step) => actualNumber + step <= finalNumber)
        .toList();
  }

  int _normalMove(List<int> legalMoves, int actualNumber, int finalNumber) {
    final safeMoves = legalMoves
        .where((move) => actualNumber + move != finalNumber - 1)
        .toList();
    if (safeMoves.isNotEmpty) {
      return safeMoves[_random.nextInt(safeMoves.length)];
    }
    return legalMoves[_random.nextInt(legalMoves.length)];
  }

  int _hardMove(List<int> legalMoves, int actualNumber, int finalNumber) {
    final targetRemainder = (finalNumber - 1) % 4;
    for (final move in legalMoves) {
      final next = actualNumber + move;
      if (next % 4 == targetRemainder) {
        return move;
      }
    }
    return _normalMove(legalMoves, actualNumber, finalNumber);
  }
}