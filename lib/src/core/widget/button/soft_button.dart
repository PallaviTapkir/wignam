import 'package:flutter/material.dart';

class SoftButton extends StatefulWidget {
  const SoftButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.color,
    this.height,
    this.width,
    this.bevel,
    this.stadiumBorder = false,
    this.dropShadow = false,
    this.highlightFactor = 0.95,
    this.shadowFactor = 0.35,
    this.borderRadius,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget child;
  final Color color;
  final double highlightFactor;
  final double shadowFactor;
  final double? height;
  final double? width;
  final double? bevel;
  final bool stadiumBorder;
  final bool dropShadow;
  final BorderRadius? borderRadius;

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  @override
  Widget build(BuildContext context) {
    final Color _highlightColor = Color.fromRGBO(
      (widget.color.red + ((255 - widget.color.red) * widget.highlightFactor))
          .toInt(),
      (widget.color.green +
              ((255 - widget.color.green) * widget.highlightFactor))
          .toInt(),
      (widget.color.blue + ((255 - widget.color.blue) * widget.highlightFactor))
          .toInt(),
      1.0,
    );
    final Color _shadowColor = Color.fromRGBO(
      (widget.color.red * (1 - widget.shadowFactor)).toInt(),
      (widget.color.green * (1 - widget.shadowFactor)).toInt(),
      (widget.color.blue * (1 - widget.shadowFactor)).toInt(),
      1.0,
    );
    final _height = widget.height ?? 32.0;
    final double _radius = widget.stadiumBorder ? _height / 2 : 16.0;
    final BorderRadius _borderRadius = BorderRadius.circular(_radius);
    final BorderRadius _innerBorderRadius =
        BorderRadius.circular(_radius * 0.75);

    return MaterialButton(
      onPressed: widget.onPressed,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius ?? _borderRadius,
      ),
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      elevation: 0.0,
      padding: EdgeInsets.zero,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? _borderRadius,
          boxShadow: [
            if (widget.dropShadow)
              BoxShadow(
                color: _shadowColor,
                blurRadius: 8.0,
                spreadRadius: -4.0,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? _borderRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? _innerBorderRadius,
              boxShadow: [
                BoxShadow(
                  color: _shadowColor,
                ),
                BoxShadow(
                  color: widget.color,
                  spreadRadius: _height * 0.75,
                  blurRadius: _height / 2.5,
                  offset: Offset(0, -(_height * 1.25)),
                ),
                BoxShadow(
                  color: _highlightColor,
                  spreadRadius: _height * 0.75,
                  blurRadius: _height / 2.5,
                  offset: Offset(0, -(_height * 1.25)),
                ),
                BoxShadow(
                  color: widget.color,
                  spreadRadius: -(widget.bevel ?? (_height / 8)),
                  blurRadius: widget.bevel ?? _height / 4,
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
