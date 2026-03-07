import 'package:gierkownia2/33_section/models/bot_33.dart';
import 'package:gierkownia2/consts/enums.dart';

class Game33 {
  Game33({
    required this.winningNumber,
    required this.isBotGame,
    this.level,
    this.userStarts = true,
  }) {
    _bot = Bot33(type: level ?? level33.easy);
    if (isBotGame && !userStarts) {
      _playOpeningBotMove();
    }
  }

  final int winningNumber;
  final bool isBotGame;
  final level33? level;
  final bool userStarts;

  late final Bot33 _bot;

  int currentNumber = 0;
  bool isPlayerOneTurn = true;
  bool isFinished = false;
  String statusText = 'Ruch gracza X';
  String? winner;

  bool canAdd(int value) {
    if (isFinished) {
      return false;
    }
    return currentNumber + value <= winningNumber;
  }

  String? playTurn(int addValue) {
    if (!canAdd(addValue)) {
      return null;
    }

    currentNumber += addValue;

    if (isBotGame) {
      if (_finishIfReachedWinningNumber(loser: 'Gracz', gameWinner: 'Bot')) {
        return winner;
      }
      final botMove = _bot.chooseMove(
        actualNumber: currentNumber,
        finalNumber: winningNumber,
      );
      currentNumber += botMove;
      if (_finishIfReachedWinningNumber(loser: 'Bot', gameWinner: 'Gracz')) {
        return winner;
      }
      statusText = 'Twój ruch';
      return null;
    }

    final currentPlayer = isPlayerOneTurn ? 'Gracz X' : 'Gracz Y';
    final otherPlayer = isPlayerOneTurn ? 'Gracz Y' : 'Gracz X';
    if (_finishIfReachedWinningNumber(
      loser: currentPlayer,
      gameWinner: otherPlayer,
    )) {
      return winner;
    }

    isPlayerOneTurn = !isPlayerOneTurn;
    statusText = isPlayerOneTurn ? 'Ruch gracza X' : 'Ruch gracza Y';
    return null;
  }

  void _playOpeningBotMove() {
    final botMove = _bot.chooseMove(
      actualNumber: currentNumber,
      finalNumber: winningNumber,
    );
    currentNumber += botMove;

    if (_finishIfReachedWinningNumber(loser: 'Bot', gameWinner: 'Gracz')) {
      return;
    }
    statusText = 'Bot zaczął. Twój ruch';
  }

  bool _finishIfReachedWinningNumber({
    required String loser,
    required String gameWinner,
  }) {
    if (currentNumber == winningNumber) {
      isFinished = true;
      winner = gameWinner;
      statusText = 'Koniec gry - $loser przegrał, wygrał $gameWinner';
      return true;
    }
    return false;
  }
}