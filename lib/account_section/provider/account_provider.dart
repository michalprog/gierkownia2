import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/models/account.dart';
import 'package:hive_ce/hive.dart';

const _accountBoxName = 'account_box';
const _accountKey = 'current_account';

final accountControllerProvider =
AsyncNotifierProvider<AccountController, Account?>(AccountController.new);

class AccountController extends AsyncNotifier<Account?> {
  @override
  Future<Account?> build() async {
    final box = await _openBox();
    final raw = box.get(_accountKey);
    if (raw is Map) {
      return Account.fromJson(raw);
    }
    return null;
  }

  Future<void> saveAccount(Account account) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final box = await _openBox();
      await box.put(_accountKey, account.toJson());
      return account;
    });
  }

  Future<Box<Map>> _openBox() async {
    if (Hive.isBoxOpen(_accountBoxName)) {
      return Hive.box<Map>(_accountBoxName);
    }
    return Hive.openBox<Map>(_accountBoxName);
  }
}