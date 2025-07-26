import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
  });
  final void Function()? onPressed;
  final Widget? icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label);
  }
}
