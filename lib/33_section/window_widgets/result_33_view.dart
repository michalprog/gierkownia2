import 'package:flutter/material.dart';
import 'package:gierkownia2/33_section/models/game_33_result.dart';
import 'package:go_router/go_router.dart';

class Result33View extends StatefulWidget {
  const Result33View({super.key, required this.currentResult});

  final Game33Result currentResult;

  @override
  State<Result33View> createState() => _Result33ViewState();
}

class _Result33ViewState extends State<Result33View> {
  final Game33ResultStorage _resultStorage = Game33ResultStorage();
  List<Game33Result> _latestResults = [];

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
    final result = widget.currentResult;

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
                      'Wynik gry: wygrał ${result.winner}',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(result.isBotGame ? 'Tryb: gracz vs bot' : 'Tryb: 2 graczy lokalnie'),
                    Text('Liczba końcowa: ${result.winningNumber}'),
                    Text('Zakończono na liczbie: ${result.finalNumber}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.goNamed('main-33'),
              child: const Text('Powrót do menu gry 33'),
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
                    (latestResult) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${latestResult.isBotGame ? 'Bot' : '2 graczy'} • wygrał: ${latestResult.winner}',
                  ),
                  subtitle: Text(
                    'max: ${latestResult.winningNumber}, koniec: ${latestResult.finalNumber}, '
                        '${latestResult.finishedAt.toLocal()}',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}