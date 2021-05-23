import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  final bool isPasswordField;
  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 1.6),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(

            border: InputBorder.none,
            hintText: hintText ?? "Hint Text...",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            )
        ),

      ),
    );
  }
}