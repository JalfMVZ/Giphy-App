import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {Color? backgroundColor, Duration duration = const Duration(seconds: 2)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ),
  );
}
