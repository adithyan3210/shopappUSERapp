import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labText;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    this.controller,
    this.labText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: labText,
          enabledBorder:
              OutlineInputBorder(),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
