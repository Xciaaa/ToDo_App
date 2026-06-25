import 'package:flutter/material.dart';
import 'package:todo_app/pages/home.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;

  const GlobalAppBar({
    super.key,
    this.title = 'What to do?',
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pinkAccent,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.favorite, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacementNamed(
            context, '/home'
          );
        },
      ),
        
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: onMenuPressed,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
