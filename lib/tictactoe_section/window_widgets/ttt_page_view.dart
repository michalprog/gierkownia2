import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TttPageView extends StatelessWidget {
  const TttPageView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goNamed('home'),
          icon: const Icon(Icons.arrow_circle_left),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text('kółko i krzyżyk'),
      ),
      body: child,
    );
  }
}