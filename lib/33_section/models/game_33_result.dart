import 'package:gierkownia2/consts/enums.dart';
import 'package:hive_ce/hive.dart';

class Game33Result {
  Game33Result({
    required this.isBotGame,
    required this.level,
    required this.winningNumber,
    required this.finalNumber,
    required this.winner,
    required this.finishedAt,
  });

  final bool isBotGame;
  final level33? level;
  final int winningNumber;
  final int finalNumber;
  final String winner;
  final DateTime finishedAt;

  Map<String, dynamic> toMap() {
    return {
      'isBotGame': isBotGame,
      'level': level?.index,
      'winningNumber': winningNumber,
      'finalNumber': finalNumber,
      'winner': winner,
      'finishedAt': finishedAt.toIso8601String(),
    };
  }

  factory Game33Result.fromMap(Map<dynamic, dynamic> map) {
    return Game33Result(
      isBotGame: map['isBotGame'] as bool? ?? false,
      level: (map['level'] as int?) == null
          ? null
          : level33.values[map['level'] as int],
      winningNumber: map['winningNumber'] as int? ?? 33,
      finalNumber: map['finalNumber'] as int? ?? 0,
      winner: map['winner'] as String? ?? 'Nieznany',
      finishedAt: DateTime.tryParse(map['finishedAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class Game33ResultStorage {
  static const _boxName = 'results_33';

  Future<void> addResult(Game33Result result) async {
    final box = await Hive.openBox<dynamic>(_boxName);
    await box.add(result.toMap());
  }

  Future<List<Game33Result>> loadLatest({int limit = 10}) async {
    final box = await Hive.openBox<dynamic>(_boxName);
    final values = box.values
        .whereType<Map<dynamic, dynamic>>()
        .map(Game33Result.fromMap)
        .toList()
      ..sort((a, b) => b.finishedAt.compareTo(a.finishedAt));

    if (values.length <= limit) {
      return values;
    }
    return values.take(limit).toList();
  }
}