import 'package:flutter/material.dart';
import 'package:gierkownia2/models/game_ttt.dart';
import 'package:gierkownia2/models/game_ttt_result.dart';
import 'package:gierkownia2/tictactoe_section/widgets/ttt_widget.dart';

class TttGameView extends StatefulWidget {
  const TttGameView({super.key, required this.isBotGame});

  final bool isBotGame;

  @override
  State<TttGameView> createState() => _TttGameViewState();
}

class _TttGameViewState extends State<TttGameView> {
  final GameTttResultStorage _resultStorage = GameTttResultStorage();
  late GameTtt _game;
  bool _savedCurrentGame = false;
  List<GameTttResult> _latestResults = [];

  @override
  void initState() {
    super.initState();
    _game = GameTtt(isBotGame: widget.isBotGame);
    _loadResults();
  }

  Future<void> _loadResults() async {
    final results = await _resultStorage.loadLatest(limit: 8);
    if (mounted) {
      setState(() {
        _latestResults = results;
      });
    }
  }

  Future<void> _handleTap(int index) async {
    final moved = _game.playAt(index);
    if (!moved) {
      return;
    }

    setState(() {});

    if (!_game.isFinished || _savedCurrentGame) {
      return;
    }

    _savedCurrentGame = true;
    await _resultStorage.addResult(
      GameTttResult(
        isBotGame: widget.isBotGame,
        winner: _game.winner ?? 'Nieznany',
        finishedAt: DateTime.now(),
      ),
    );

    await _loadResults();

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Koniec gry'),
        content: Text(_game.statusText),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _game = GameTtt(isBotGame: widget.isBotGame);
      _savedCurrentGame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Text(
                      widget.isBotGame
                          ? 'Tryb: gracz vs bot'
                          : 'Tryb: 2 graczy lokalnie',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(_game.statusText, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return TttWidget(
                  value: _game.board[index],
                  onTap: () => _handleTap(index),
                );
              },
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _resetGame,
              icon: const Icon(Icons.refresh),
              label: const Text('Nowa gra'),
            ),
            const SizedBox(height: 16),
            Text(
              'Ostatnie wyniki (zapis lokalny)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (_latestResults.isEmpty)
              const Text('Brak zapisanych wyników')
            else
              ..._latestResults.map(
                    (result) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${result.isBotGame ? 'Bot' : '2 graczy'} • wynik: ${result.winner}',
                  ),
                  subtitle: Text('${result.finishedAt.toLocal()}'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}