import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'design_theme.dart';

class DesignButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const DesignButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (DesignSDK.currentStyle == AppDesignStyle.apple) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        child: child,
      );
    }
    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
