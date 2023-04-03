import 'package:flutter/material.dart';

import 'button/soft_button.dart';

class SoftButtonWithDivider extends StatelessWidget {
  const SoftButtonWithDivider({
    Key? key,
    required this.onPressed,
    required this.child,
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
  final Widget child;
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
        Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SoftButton(
              onPressed: onPressed,
              color: color,
              highlightFactor: highlightFactor,
              shadowFactor: shadowFactor,
              width: width,
              height: height,
              bevel: bevel,
              child: child,
            ),
          ),
        )
      ],
    );
  }
}
