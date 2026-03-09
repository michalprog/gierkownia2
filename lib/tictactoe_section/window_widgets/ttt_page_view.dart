import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TttPageView extends StatelessWidget {
  const TttPageView({super.key, required this.widget});
final Widget widget;
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
        title: const Text('kółko i krzyżyk'),
      ),
      body: widget,

    );
  }
}
