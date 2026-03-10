import 'package:flutter/material.dart';

class AppBarUserWidget extends StatelessWidget {
  const AppBarUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){},
        icon: Icon(Icons.account_circle_outlined, size: 35),

    );
  }
}
