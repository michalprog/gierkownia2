import 'package:flutter/material.dart';
import 'package:gierkownia2/33_section/widgets/action_button_33.dart';
import 'package:go_router/go_router.dart';

class TttMainView extends StatelessWidget {
  const TttMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ActionButton33(
          title: 'rozpocznij grę ',
          secondLineTitle: '(1 vs 1 lokalnie) ',
          onPressed: () => context.goNamed(
            'ttt-game',
            queryParameters: const {'mode': 'local'},
          ),
        ),
        const SizedBox(height: 12),
        ActionButton33(
          title: 'rozpocznij grę ',
          secondLineTitle: '(z botem) ',
          onPressed: () => context.goNamed(
            'ttt-game',
            queryParameters: const {'mode': 'bot'},
          ),
        ),
      ],
    );
  }
}