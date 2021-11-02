import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String labelText;
  final String helperText;
  final bool isPassword;
  final String Function(String) textValidator;
  final TextEditingController textEditingController;
  const TextWidget({
    Key key,
    @required this.labelText,
    @required this.textEditingController,
    this.helperText,
    @required this.isPassword,
    this.textValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            validator: textValidator,
            obscureText: isPassword,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
            controller: textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding: const EdgeInsets.all(12),

              helperText: helperText,
              helperStyle: const TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),
              labelText: labelText,
              // ignore: prefer_const_constructors
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),

              fillColor: Colors.white,

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                // ignore: prefer_const_constructors
                borderSide: BorderSide(
                  color: Colors.teal,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                // ignore: prefer_const_constructors
                borderRadius: BorderRadius.circular(25.0),
                // ignore: prefer_const_constructors
                borderSide: BorderSide(
                  color: Colors.grey.shade600,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ]);
  }
}
