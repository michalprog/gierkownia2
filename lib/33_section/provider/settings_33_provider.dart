import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/33_section/models/setting_33_file.dart';
import 'package:gierkownia2/consts/enums.dart';

final settings33StorageProvider = Provider<Settings33Storage>((ref) {
  return Settings33Storage();
});

final settings33Provider =
NotifierProvider<Settings33Controller, Setting33File>(
  Settings33Controller.new,
);

class Settings33Controller extends Notifier<Setting33File> {
  late final Settings33Storage _storage;
  bool _isInitialized = false;

  @override
  Setting33File build() {
    _storage = ref.watch(settings33StorageProvider);

    if (!_isInitialized) {
      _isInitialized = true;
      unawaited(loadSettings());
    }

    return Setting33File(level: level33.easy, winningNumber: 33);
  }

  Future<void> loadSettings() async {
    state = await _storage.loadSettings();
  }

  Future<void> updateLevel(level33 level) async {
    state = state.copyWith(level: level);
    await _storage.saveSettings(state);
  }

  Future<void> updateWinningNumber(int winningNumber) async {
    state = state.copyWith(winningNumber: winningNumber);
    await _storage.saveSettings(state);
  }
}