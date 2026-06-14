import 'package:flutter/material.dart';

class GlobalFab extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final IconData icon;
  final Color iconColor;

  const GlobalFab({
    super.key,
    this.onPressed,
    this.backgroundColor = Colors.pinkAccent,
    this.icon = Icons.add,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: Icon(icon, color: iconColor),
    );
  }
}
