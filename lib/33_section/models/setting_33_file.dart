import 'package:gierkownia2/consts/enums.dart';
import 'package:hive_ce/hive.dart';

class Setting33File {
  level33 level;
  int winningNumber;
  bool userStarts;
  bool isLoaded;

  Setting33File({
    required this.winningNumber,
    required this.level,
    required this.userStarts,
    this.isLoaded = true,
  });

  Setting33File copyWith({
    level33? level,
    int? winningNumber,
    bool? userStarts,
    bool? isLoaded,
  }) {
    return Setting33File(
      level: level ?? this.level,
      winningNumber: winningNumber ?? this.winningNumber,
      userStarts: userStarts ?? this.userStarts,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level.index,
      'winningNumber': winningNumber,
      'userStarts': userStarts,
    };
  }

  factory Setting33File.fromMap(Map<dynamic, dynamic> map) {
    return Setting33File(
      level: level33.values[map['level'] as int? ?? level33.easy.index],
      winningNumber: map['winningNumber'] as int? ?? 33,
      userStarts: map['userStarts'] as bool? ?? true,
      isLoaded: true,
    );
  }

  factory Setting33File.initial() {
    return Setting33File(
      level: level33.easy,
      winningNumber: 33,
      userStarts: true,
      isLoaded: false,
    );
  }
}

class Settings33Storage {
  static const _boxName = 'settings_33';

  Future<Setting33File> loadSettings() async {
    final box = await Hive.openBox<dynamic>(_boxName);
    final map = box.get('settings', defaultValue: <String, dynamic>{})
    as Map<dynamic, dynamic>;
    return Setting33File.fromMap(map);
  }

  Future<void> saveSettings(Setting33File settings) async {
    final box = await Hive.openBox<dynamic>(_boxName);
    await box.put('settings', settings.toMap());
  }
}