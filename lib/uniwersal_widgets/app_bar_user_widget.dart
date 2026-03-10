import 'package:flutter/material.dart';
import 'package:gierkownia2/models/account.dart';

import 'package:gierkownia2/uniwersal_widgets/account_bottom_sheet.dart';

class AppBarUserWidget extends StatelessWidget {
  const AppBarUserWidget({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => AccountBottomSheet(account: account),
        );
      },
      icon: const Icon(Icons.account_circle_outlined, size: 35),
    );
  }
}