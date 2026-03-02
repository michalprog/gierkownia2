import 'package:flutter/material.dart';

class ChooseGameButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  /// Opcjonalnie: pozwala sterować maks. szerokością na desktop/web
  final double maxWidth;

  /// Opcjonalnie: wysokość przycisku
  final double height;

  const ChooseGameButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.maxWidth = 520,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;

        final bool isWide = w >= 600;

        final horizontalPadding = isWide ? 28.0 : 18.0;
        final fontSize = isWide ? 18.0 : 16.0;

        final buttonWidth = w.isFinite ? (w > maxWidth ? maxWidth : w) : maxWidth;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: buttonWidth, height: height),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height / 2), // „pill”
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}