import 'package:hive_ce/hive.dart';

class GameTttResult {
  GameTttResult({
    required this.isBotGame,
    required this.winner,
    required this.finishedAt,
  });

  final bool isBotGame;
  final String winner;
  final DateTime finishedAt;

  Map<String, dynamic> toMap() {
    return {
      'isBotGame': isBotGame,
      'winner': winner,
      'finishedAt': finishedAt.toIso8601String(),
    };
  }

  factory GameTttResult.fromMap(Map<dynamic, dynamic> map) {
    return GameTttResult(
      isBotGame: map['isBotGame'] as bool? ?? false,
      winner: map['winner'] as String? ?? 'Nieznany',
      finishedAt: DateTime.tryParse(map['finishedAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class GameTttResultStorage {
  static const _boxName = 'results_ttt';

  Future<void> addResult(GameTttResult result) async {
    final box = await Hive.openBox<dynamic>(_boxName);
    await box.add(result.toMap());
  }

  Future<List<GameTttResult>> loadLatest({int limit = 10}) async {
    final box = await Hive.openBox<dynamic>(_boxName);
    final values = box.values
        .whereType<Map<dynamic, dynamic>>()
        .map(GameTttResult.fromMap)
        .toList()
      ..sort((a, b) => b.finishedAt.compareTo(a.finishedAt));

    if (values.length <= limit) {
      return values;
    }
    return values.take(limit).toList();
  }
}