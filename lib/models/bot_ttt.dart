import 'dart:math';

class BotTtt {
  final Random _random = Random();

  int chooseMove({
    required List<String?> board,
    required String botSymbol,
    required String playerSymbol,
  }) {
    final moves = _availableMoves(board);
    if (moves.isEmpty) {
      return -1;
    }

    for (final move in moves) {
      final probe = [...board];
      probe[move] = botSymbol;
      if (_isWinner(probe, botSymbol)) {
        return move;
      }
    }

    for (final move in moves) {
      final probe = [...board];
      probe[move] = playerSymbol;
      if (_isWinner(probe, playerSymbol)) {
        return move;
      }
    }

    if (board[4] == null) {
      return 4;
    }

    final corners = [0, 2, 6, 8].where((idx) => board[idx] == null).toList();
    if (corners.isNotEmpty) {
      return corners[_random.nextInt(corners.length)];
    }

    return moves[_random.nextInt(moves.length)];
  }

  List<int> _availableMoves(List<String?> board) {
    return List<int>.generate(board.length, (index) => index)
        .where((index) => board[index] == null)
        .toList();
  }

  bool _isWinner(List<String?> board, String symbol) {
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
      if (board[line[0]] == symbol &&
          board[line[1]] == symbol &&
          board[line[2]] == symbol) {
        return true;
      }
    }
    return false;
  }
}