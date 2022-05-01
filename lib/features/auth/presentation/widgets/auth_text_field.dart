import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    required this.textInputType,
    required this.controller,
    this.onChanged,
    this.textInputAction,
  }) : super(key: key);

  final String hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          contentPadding: const EdgeInsets.all(8.0),
          errorText: errorText,
        ),
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        onChanged: onChanged,
        textInputAction: textInputAction ?? TextInputAction.next,
      ),
    );
  }
}
