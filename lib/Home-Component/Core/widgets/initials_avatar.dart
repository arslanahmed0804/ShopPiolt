import 'package:flutter/material.dart';

class InitialsAvatar extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  final bool circle;
  final double size;

  const InitialsAvatar({
    super.key,
    required this.text,
    required this.bg,
    required this.fg,
    this.circle = false,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(16),
      ),
      child: Text(text, style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 14)),
    );
  }
}