import 'package:flutter/material.dart';

class ActionButton33 extends StatelessWidget {
  const ActionButton33({
    super.key,
    required this.title,
    this.secondLineTitle,
    required this.onPressed,
  });

  final String title;
  final String? secondLineTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool hasSecondLine = secondLineTitle != null;

    return SizedBox(
      height: hasSecondLine ? 72 : 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (hasSecondLine)
              Text(
                secondLineTitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}