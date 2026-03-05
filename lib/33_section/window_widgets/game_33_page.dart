import 'package:flutter/material.dart';

class Game33Page extends StatelessWidget {
  const Game33Page({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Gra 33')), body: child);
  }
}