import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gierkownia2/main_section/widgets/choose_game_button.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text("gierkownia 2.0"),
        actions: [
        IconButton(
        onPressed: () {},
    icon: Icon(Icons.account_circle_outlined, size: 35),
    ),
    ],
    ),
    body: ListView(
        children: [
          ChooseGameButton(title: "gra 33", onPressed: () => context.goNamed('main-33'),),
          ChooseGameButton(title: "kółko i krzyżyk", onPressed: (){}),
      ],

    ),

    );
  }
}
