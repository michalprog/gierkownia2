import 'package:flutter/material.dart';
import 'package:gierkownia2/tictactoe_section/models/game_ttt_result.dart';
import 'package:go_router/go_router.dart';

class TttResultView extends StatefulWidget {
  const TttResultView({super.key, required this.currentResult});

  final GameTttResult currentResult;

  @override
  State<TttResultView> createState() => _TttResultViewState();
}

class _TttResultViewState extends State<TttResultView> {
  final GameTttResultStorage _resultStorage = GameTttResultStorage();
  List<GameTttResult> _latestResults = [];

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final results = await _resultStorage.loadLatest(limit: 8);
    if (!mounted) {
      return;
    }

    setState(() {
      _latestResults = results;
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
                      'Wynik gry: ${widget.currentResult.winner}',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.currentResult.isBotGame
                          ? 'Tryb: gracz vs bot'
                          : 'Tryb: 2 graczy lokalnie',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.goNamed('ttt-main'),
              child: const Text('Powrót do menu kółko i krzyżyk'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Powrót do widoku głównego'),
            ),
            const SizedBox(height: 16),
            Text(
              'Ostatnie wyniki',
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