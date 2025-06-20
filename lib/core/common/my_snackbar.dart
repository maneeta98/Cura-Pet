import 'package:flutter/material.dart';

/// Displays a custom snackbar message.
///
/// [context]: The build context.
/// [message]: The message to show inside the snackbar.
/// [color]: Optional background color (defaults to green).
void showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
