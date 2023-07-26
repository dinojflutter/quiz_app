import 'package:flutter/material.dart';

class Gradientdecoration extends StatelessWidget {
  final Widget child;
  const Gradientdecoration({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.shade800,
            Colors.teal.shade200,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
