import 'package:flutter/material.dart';

class FlatBottomSoftButton extends StatefulWidget {
  const FlatBottomSoftButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.color,
    this.height,
    this.width,
    this.highlightFactor = 0.95,
    this.shadowFactor = 0.35,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget child;
  final Color color;
  final double? height;
  final double? width;
  final double highlightFactor;
  final double shadowFactor;

  @override
  FlatBottomSoftButtonState createState() => FlatBottomSoftButtonState();
}

class FlatBottomSoftButtonState extends State<FlatBottomSoftButton> {
  @override
  Widget build(BuildContext context) {
    final Color highlightColor = Color.fromRGBO(
      (widget.color.red + ((255 - widget.color.red) * widget.highlightFactor))
          .toInt(),
      (widget.color.green +
              ((255 - widget.color.green) * widget.highlightFactor))
          .toInt(),
      (widget.color.blue + ((255 - widget.color.blue) * widget.highlightFactor))
          .toInt(),
      1.0,
    );
    final Color shadowColor = Color.fromRGBO(
      (widget.color.red * (1 - widget.shadowFactor)).toInt(),
      (widget.color.green * (1 - widget.shadowFactor)).toInt(),
      (widget.color.blue * (1 - widget.shadowFactor)).toInt(),
      1.0,
    );
    return MaterialButton(
      onPressed: widget.onPressed,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      hoverElevation: 16.0,
      focusElevation: 16.0,
      highlightElevation: 16.0,
      elevation: 16.0,
      padding: EdgeInsets.zero,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              // color: BrandColors.primaryLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color,
                ),
                BoxShadow(
                  color: highlightColor,
                  spreadRadius: 8.0,
                  blurRadius: 0.0,
                ),
                BoxShadow(
                  color: widget.color,
                  // color: Colors.black,
                  spreadRadius: 4.0,
                  blurRadius: 4.0,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: shadowColor,
                  spreadRadius: 8.0,
                  blurRadius: 8.0,
                  offset: Offset(0, (widget.height ?? 48.0) - 4),
                ),
              ],
            ),
            child: Center(
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
