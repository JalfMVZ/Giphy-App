import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {Color? backgroundColor, Duration duration = const Duration(seconds: 2)}) {
  final scaffoldContext = ScaffoldMessenger.of(context);
  scaffoldContext.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      duration: duration,
    ),
  );
}
