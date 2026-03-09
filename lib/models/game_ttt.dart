import 'package:gierkownia2/models/bot_ttt.dart';

class GameTtt {
  GameTtt({required this.isBotGame});

  final bool isBotGame;
  final BotTtt _bot = BotTtt();

  final List<String?> board = List<String?>.filled(9, null);
  bool isXTurn = true;
  bool isFinished = false;
  String? winner;
  String statusText = 'Ruch gracza X';

  bool playAt(int index) {
    if (isFinished || index < 0 || index >= board.length || board[index] != null) {
      return false;
    }

    board[index] = isXTurn ? 'X' : 'O';
    _evaluateAfterMove();

    if (isBotGame && !isFinished) {
      final botIndex = _bot.chooseMove(
        board: board,
        botSymbol: 'O',
        playerSymbol: 'X',
      );
      if (botIndex >= 0 && board[botIndex] == null) {
        board[botIndex] = 'O';
        isXTurn = false;
        _evaluateAfterMove();
      }
    }

    return true;
  }

  void _evaluateAfterMove() {
    final currentWinner = _checkWinner();
    if (currentWinner != null) {
      isFinished = true;
      winner = currentWinner;
      statusText = 'Koniec gry - wygrał $currentWinner';
      return;
    }

    if (board.every((cell) => cell != null)) {
      isFinished = true;
      winner = 'Remis';
      statusText = 'Koniec gry - remis';
      return;
    }

    isXTurn = !isXTurn;
    if (isBotGame) {
      statusText = isXTurn ? 'Twój ruch (X)' : 'Ruch bota (O)';
    } else {
      statusText = isXTurn ? 'Ruch gracza X' : 'Ruch gracza O';
    }
  }

  String? _checkWinner() {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final line in lines) {
      final a = board[line[0]];
      final b = board[line[1]];
      final c = board[line[2]];
      if (a != null && a == b && b == c) {
        return a;
      }
    }
    return null;
  }
}