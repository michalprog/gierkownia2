import 'package:flutter/material.dart';
import 'package:gierkownia2/main_section/widgets/choose_game_button.dart';
import 'package:gierkownia2/models/account.dart';
import 'package:gierkownia2/uniwersal_widgets/app_bar_user_widget.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final demoAccount = Account(
      userId: '1',
      userLogin: 'gracz_01',
      password: 'haslo_demo',
      mail: 'gracz01@example.com',
      status: 'active',
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text('gierkownia 2.0'),
        actions: [
          AppBarUserWidget(account: demoAccount),
        ],
      ),
      body: ListView(
        children: [
          ChooseGameButton(
            title: 'gra 33',
            onPressed: () => context.goNamed('main-33'),
          ),
          ChooseGameButton(
            title: 'kółko i krzyżyk',
            onPressed: () => context.goNamed('ttt-main'),
          ),
        ],
      ),
    );
  }
}