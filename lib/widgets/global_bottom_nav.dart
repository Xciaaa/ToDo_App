import 'package:flutter/material.dart';

class GlobalBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GlobalBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,

      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),

      items:  [
        BottomNavigationBarItem(
          icon: _AnimatedNavIcon(iconData: Icons.home, isSelected: currentIndex == 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _AnimatedNavIcon(iconData: Icons.calendar_month, isSelected: currentIndex == 1),
          label: 'Calendar',
        ),
      ],
    );
  }
}

class _AnimatedNavIcon extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;

  const _AnimatedNavIcon({required this.iconData, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.25 : 1.0, // Pops out slightly when selected
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutBack, // Gives it a snappy bounce feeling
      child: AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.6, // Fades unselected items slightly
        duration: const Duration(milliseconds: 200),
        child: Icon(iconData),
      ),
    );
  }
}