import 'package:flutter/material.dart';

import 'app_theme.dart';

class CTextButton extends StatefulWidget {
  const CTextButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  State<CTextButton> createState() => _CTextButtonState();
}

class _CTextButtonState extends State<CTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: const TextStyle(
          color: AppThemeData.textPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
