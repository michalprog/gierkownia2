import 'package:flutter/material.dart';
import 'package:gierkownia2/33_section/widgets/action_button_33.dart';

class Main33View extends StatelessWidget {
  const Main33View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
children: [
  Row(
    children: [
      ActionButton33(title: "rozpocznij grę ",
          secondLineTitle: "(1 vs 1 lokalnie) ",
          onPressed: (){}),
      ActionButton33(title: "rozpocznij grę ",
          secondLineTitle: "(z botem) ",
          onPressed: (){}),
      ActionButton33(title: "rozpocznij grę ",
          secondLineTitle: "(1 vs 1 sieć) ",
          onPressed: (){}),

    ],
  ),
],

        ),
      ),

    );
  }
}
