import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gierkownia2/33_section/models/setting_33_file.dart';
import 'package:gierkownia2/consts/enums.dart';

final settings33StorageProvider = Provider<Settings33Storage>((ref) {
  return Settings33Storage();
});

final settings33Provider =
StateNotifierProvider<Settings33Controller, Setting33File>((ref) {
  final storage = ref.watch(settings33StorageProvider);
  final controller = Settings33Controller(storage);
  controller.loadSettings();
  return controller;
});

class Settings33Controller extends StateNotifier<Setting33File> {
  Settings33Controller(this._storage) : super(Setting33File.initial());

  final Settings33Storage _storage;

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

  Future<void> updateUserStarts(bool userStarts) async {
    state = state.copyWith(userStarts: userStarts);
    await _storage.saveSettings(state);
  }
}