import 'package:flutter/material.dart';

class Actionbottom extends StatelessWidget {
  const Actionbottom({
    super.key,
    required this.title,
    required this.ontap,
  });

  final String title;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 200,
        child: ElevatedButton(onPressed: () => ontap(), child: Text(title)));
  }
}
