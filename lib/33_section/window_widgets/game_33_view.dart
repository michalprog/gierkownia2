import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/33_section/models/game_33.dart';
import 'package:gierkownia2/33_section/models/game_33_result.dart';
import 'package:gierkownia2/33_section/provider/settings_33_provider.dart';
import 'package:go_router/go_router.dart';

class Game33View extends ConsumerStatefulWidget {
  const Game33View({super.key, required this.isBotGame});

  final bool isBotGame;

  @override
  ConsumerState<Game33View> createState() => _Game33ViewState();
}

class _Game33ViewState extends ConsumerState<Game33View> {
  final Game33ResultStorage _resultStorage = Game33ResultStorage();

  Game33? _game;
  bool _savedCurrentGame = false;

  void _ensureGame({required bool userStarts}) {
    if (_game != null) {
      return;
    }
    final settings = ref.read(settings33Provider);
    _game = Game33(
      winningNumber: settings.winningNumber,
      isBotGame: widget.isBotGame,
      level: widget.isBotGame ? settings.level : null,
      userStarts: userStarts,
    );
  }

  Future<void> _handleMove(int move, {required bool userStarts}) async {
    _ensureGame(userStarts: userStarts);
    setState(() {
      _game?.playTurn(move);
    });

    final game = _game;
    if (game == null || !game.isFinished || _savedCurrentGame) {
      return;
    }

    _savedCurrentGame = true;
    final result = Game33Result(
      isBotGame: widget.isBotGame,
      level: game.level,
      winningNumber: game.winningNumber,
      finalNumber: game.currentNumber,
      winner: game.winner ?? 'Nieznany',
      finishedAt: DateTime.now(),
    );
    await _resultStorage.addResult(result);

    if (!mounted) {
      return;
    }

    context.goNamed('result-33', extra: result);
  }

  void _resetGame() {
    setState(() {
      _game = null;
      _savedCurrentGame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settings33Provider);

    if (!settings.isLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    _ensureGame(userStarts: settings.userStarts);
    final game = _game!;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.isBotGame ? 'Tryb: gracz vs bot' : 'Tryb: 2 graczy lokalnie',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (widget.isBotGame)
                      Text(
                        'Poziom bota: ${game.level?.name ?? 'easy'}',
                        textAlign: TextAlign.center,
                      ),
                    if (widget.isBotGame)
                      Text(
                        settings.userStarts ? 'Startuje użytkownik' : 'Startuje bot',
                        textAlign: TextAlign.center,
                      ),
                    Text(
                      'Liczba końcowa: ${game.winningNumber}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Aktualna liczba: ${game.currentNumber}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(game.statusText, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [1, 2, 3]
                  .map(
                    (value) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: game.canAdd(value)
                          ? () => _handleMove(value, userStarts: settings.userStarts)
                          : null,
                      child: Text('+$value'),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _resetGame,
              icon: const Icon(Icons.refresh),
              label: const Text('Nowa gra'),
            ),
          ],
        ),
      ),
    );
  }
}