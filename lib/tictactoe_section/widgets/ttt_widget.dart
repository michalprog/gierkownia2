import 'package:flutter/material.dart';

class TttWidget extends StatelessWidget {
  const TttWidget({
    super.key,
    required this.value,
    required this.onTap,
  });

  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = value == 'X'
        ? Colors.blueAccent
        : value == 'O'
        ? Colors.deepOrange
        : Colors.black54;

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Center(
              child: Text(
                value ?? '',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}