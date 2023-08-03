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
            Colors.orange.shade900,
            Colors.orange.shade100,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
