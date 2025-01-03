import 'package:flutter/material.dart';
import 'package:todo_app_ga/features/common/presentation/widget/custom_text_widget.dart';
import 'package:todo_app_ga/features/common/presentation/widget/dialog_text_button.dart';

Future<bool?> showCustomDialog({
  required BuildContext context,
  String title = 'Do you want to do that?',
  String content = 'Are you sure that you want to do that?',
  String confirmText = 'Do that',
  String cancelText = 'Cancel',
  Color confirmColor = const Color(0xFFCE2029),
  Color cancelColor = const Color(0xFF757575),
}) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: Color(0xFFFFE4E4),
            width: 2.0,
          ),
        ),
        title: CustomText(
          text: title,
          fontSize: 20,
          color: const Color(0xFF212121),
          fontWeight: FontWeight.w600,
        ),
        content: CustomText(
          text: content,
          color: const Color(0xFF757575),
          fontWeight: FontWeight.w400,
        ),
        actions: [
          DialogTextButton(
            onPressed: () => Navigator.of(context).pop(false),
            text: cancelText,
            textColor: cancelColor,
          ),
          DialogTextButton(
            onPressed: () => Navigator.of(context).pop(true),
            text: confirmText,
            textColor: confirmColor,
          )
        ],
      );
    },
  );
}
