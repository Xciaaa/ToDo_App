import 'package:flutter/material.dart';

class GlobalFab extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final IconData icon;
  final Color iconColor;

  const GlobalFab({
    super.key,
    this.onPressed,
    this.backgroundColor = const Color.fromARGB(200,221,166,184,),
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
