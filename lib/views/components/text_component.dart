import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  const TextComponent(
      {super.key,
      required this.text,
      this.style,
      this.size,
      this.color,
      this.fontWeight});
  final String text;
  final TextStyle? style;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: style ??
          TextStyle(
              fontSize: size,
              color: color,
              fontWeight: fontWeight,
              overflow: TextOverflow.ellipsis),
    );
  }
}
