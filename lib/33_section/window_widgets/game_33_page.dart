import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Game33Page extends StatelessWidget {
  const Game33Page({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goNamed('home'),
          icon: Icon(Icons.arrow_circle_left),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text('Gra 33'),
      ),
      body: child,
    );
  }
}
