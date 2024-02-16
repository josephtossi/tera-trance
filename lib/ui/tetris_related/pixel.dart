import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

// ignore: must_be_immutable
class Pixel extends StatelessWidget {
  Color color;
  Widget child;

  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(color == Colors.transparent ? 0 : 1),
      decoration: BoxDecoration(
        border: color == Colors.transparent ?
        GradientBoxBorder(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.lightBlueAccent.withOpacity (.2)]),
          width: .3,
        ) :
        GradientBoxBorder(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffaff0f7), Color(0xffb1f1f7), Colors.lightBlueAccent]),
          width: 3,
        ),
        color: color,
      ),
      child: child,
    );
  }
}
