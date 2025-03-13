import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  final double minWidth;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double? elevation;

  const AuthButtonWidget({
    super.key,
    required this.child,
    required this.color,
    required this.onPressed,
    this.elevation,
    this.borderRadius = const BorderRadius.all(Radius.circular(30.0)),
    this.height = 42.0,
    this.minWidth = 200.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: color,
        borderRadius: borderRadius,
        elevation: elevation ?? 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: minWidth,
          height: height,
          child: child,
        ),
      ),
    );
  }
}
