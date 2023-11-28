import 'package:flutter/material.dart';
import 'app_theme.dart';

class CTextField extends StatefulWidget {
  const CTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.textEditingController,
    required this.keyboardType,
    required this.isMaxLength,
  }) : super(key: key);

  final String? labelText, hintText;
  final bool isPassword;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool isMaxLength;

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align hint text to the left
        children: [
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            obscureText: widget.isPassword ? _isObscure : false,
            maxLength: widget.isMaxLength ? 20 : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.solid,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: AppThemeData.textGreyLight), // Hint text color
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      color: AppThemeData.textGreyDark,
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : Icon(
                      widget.labelText == "Username" ||
                              widget.labelText == "First Name" ||
                              widget.labelText == "Last Name"
                          ? Icons.person
                          : widget.labelText == "Email"
                              ? Icons.email_rounded
                              : Icons.numbers,
                      color: AppThemeData.textGreyDark,
                    ),
            ),
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}
