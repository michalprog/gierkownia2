import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/33_section/provider/settings_33_provider.dart';
import 'package:gierkownia2/consts/enums.dart';
import 'package:go_router/go_router.dart';

class Settings33View extends ConsumerWidget {
  const Settings33View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settings33Provider);
    final settingsController = ref.read(settings33Provider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<level33>(
              value: settings.level,
              decoration: const InputDecoration(
                labelText: 'Poziom trudności bota',
                border: OutlineInputBorder(),
              ),
              items: level33.values
                  .map(
                    (level) => DropdownMenuItem(
                  value: level,
                  child: Text(level.name),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  settingsController.updateLevel(value);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Liczba kończąca grę (33-100)'),
                Slider(
                  min: 33,
                  max: 100,
                  divisions: 67,
                  value: settings.winningNumber.toDouble(),
                  label: settings.winningNumber.toString(),
                  onChanged: (value) {
                    settingsController.updateWinningNumber(value.round());
                  },
                ),
                Text('Wybrana liczba: ${settings.winningNumber}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: SwitchListTile(
            title: const Text('Kto zaczyna w grze z botem'),
            subtitle: Text(settings.userStarts ? 'Zaczyna użytkownik' : 'Zaczyna bot'),
            value: settings.userStarts,
            onChanged: settingsController.updateUserStarts,
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => context.goNamed('main-33'),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Powrót do głównego widoku'),
        ),
      ],
    );
  }
}