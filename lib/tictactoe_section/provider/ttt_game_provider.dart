import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/tictactoe_section/models/game_ttt.dart';

class TttGameState {
  const TttGameState({required this.game, required this.savedCurrentGame});

  final GameTtt game;
  final bool savedCurrentGame;

  TttGameState copyWith({GameTtt? game, bool? savedCurrentGame}) {
    return TttGameState(
      game: game ?? this.game,
      savedCurrentGame: savedCurrentGame ?? this.savedCurrentGame,
    );
  }
}

class TttGameNotifier extends Notifier<TttGameState> {
  TttGameNotifier({required bool isBotGame}) : _isBotGame = isBotGame;

  final bool _isBotGame;

  @override
  TttGameState build() {
    return TttGameState(
      game: GameTtt(isBotGame: _isBotGame),
      savedCurrentGame: false,
    );
  }

  bool playAt(int index) {
    final moved = state.game.playAt(index);
    if (!moved) {
      return false;
    }

    state = state.copyWith();
    return true;
  }

  void markResultAsSaved() {
    if (state.savedCurrentGame) {
      return;
    }

    state = state.copyWith(savedCurrentGame: true);
  }

  void resetGame() {
    state = TttGameState(
      game: GameTtt(isBotGame: _isBotGame),
      savedCurrentGame: false,
    );
  }
}

final tttGameProvider = NotifierProvider.family<TttGameNotifier, TttGameState, bool>(
      (isBotGame) => TttGameNotifier(isBotGame: isBotGame),
);