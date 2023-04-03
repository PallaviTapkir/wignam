import 'package:flutter/material.dart';

import '../value/colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {Key? key,
      required this.normalText,
      required this.highlightedText,
      this.textSize = 18.0,
      this.padding = const EdgeInsets.symmetric(horizontal: 16.0)})
      : super(key: key);

  final String normalText;
  final String highlightedText;
  final EdgeInsets padding;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RichText(
          text: TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
              text: '$normalText ',
              style: const TextStyle(color: Colors.black)),
          TextSpan(
              text: highlightedText,
              style: const TextStyle(color: AppColors.secondary)),
        ],
      )),
    );
  }
}
