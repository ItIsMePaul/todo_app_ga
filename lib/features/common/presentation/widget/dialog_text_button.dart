import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/features/common/presentation/widget/custom_text_widget.dart';

class DialogTextButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  const DialogTextButton(
      {required this.onPressed,
      required this.text,
      required this.textColor,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        child: CustomText(
          text: text,
          color: textColor,
          fontWeight: FontWeight.w500,
        ));
  }
}
