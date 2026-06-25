import 'package:flutter/material.dart';

class SmoothPageRoute extends PageRouteBuilder {
  final Widget child;

  SmoothPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    
    final curve = CurvedAnimation(
      parent: animation, 
      curve: Curves.fastOutSlowIn,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1.0).animate(curve),
        child: child,
      ),
    );
  }
}