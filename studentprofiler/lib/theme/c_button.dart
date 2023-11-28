import 'package:flutter/material.dart';
import 'package:studentprofiler/theme/app_theme.dart';

class CButton extends StatefulWidget {
  const CButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  State<CButton> createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppThemeData.buttonSecondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
