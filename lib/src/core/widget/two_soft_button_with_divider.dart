import 'package:flutter/material.dart';

import 'button/soft_button.dart';

class TwoSoftButtonWithDivider extends StatelessWidget {
  const TwoSoftButtonWithDivider({
    Key? key,
    required this.onPressed,
    required this.onPressed2,
    required this.child1,
    required this.child2,
    required this.color,
    this.dividerColor = Colors.grey,
    this.height,
    this.width,
    this.bevel,
    this.stadiumBorder = false,
    this.dropShadow = false,
    this.highlightFactor = 0.95,
    this.shadowFactor = 0.35,
    this.alignment = Alignment.centerRight,
  }) : super(key: key);

  final void Function()? onPressed;
  final void Function()? onPressed2;
  final Widget child1;
  final Widget child2;
  final Color color;
  final Color dividerColor;
  final double highlightFactor;
  final double shadowFactor;
  final double? height;
  final double? width;
  final double? bevel;
  final bool stadiumBorder;
  final bool dropShadow;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: dividerColor,
          indent: 0.0,
          endIndent: 0.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SoftButton(
                onPressed: onPressed,
                color: Colors.white10,
                highlightFactor: highlightFactor,
                shadowFactor: shadowFactor,
                width: width,
                height: height,
                bevel: bevel,
                child: child1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SoftButton(
                onPressed: onPressed2,
                color: color,
                highlightFactor: highlightFactor,
                shadowFactor: shadowFactor,
                width: width,
                height: height,
                bevel: bevel,
                child: child2,
              ),
            )
          ],
        )
      ],
    );
  }
}
