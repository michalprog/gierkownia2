import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/tictactoe_section/models/game_ttt_result.dart';
import 'package:gierkownia2/tictactoe_section/provider/ttt_game_provider.dart';
import 'package:gierkownia2/tictactoe_section/widgets/ttt_widget.dart';
import 'package:go_router/go_router.dart';

class TttGameView extends ConsumerWidget {
  const TttGameView({super.key, required this.isBotGame});

  final bool isBotGame;

  Future<void> _handleTap(BuildContext context, WidgetRef ref, int index) async {
    final notifier = ref.read(tttGameProvider(isBotGame).notifier);
    final moved = notifier.playAt(index);
    if (!moved) {
      return;
    }

    final state = ref.read(tttGameProvider(isBotGame));
    final game = state.game;

    if (!game.isFinished || state.savedCurrentGame) {
      return;
    }

    notifier.markResultAsSaved();

    final result = GameTttResult(
      isBotGame: isBotGame,
      winner: game.winner ?? 'Nieznany',
      finishedAt: DateTime.now(),
    );

    await GameTttResultStorage().addResult(result);

    if (!context.mounted) {
      return;
    }

    context.goNamed('ttt-result', extra: result);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tttGameProvider(isBotGame));
    final game = state.game;

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
                      isBotGame ? 'Tryb: gracz vs bot' : 'Tryb: 2 graczy lokalnie',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(game.statusText, textAlign: TextAlign.center),
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
                  value: game.board[index],
                  onTap: () => _handleTap(context, ref, index),
                );
              },
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => ref.read(tttGameProvider(isBotGame).notifier).resetGame(),
              icon: const Icon(Icons.refresh),
              label: const Text('Nowa gra'),
            ),
          ],
        ),
      ),
    );
  }
}