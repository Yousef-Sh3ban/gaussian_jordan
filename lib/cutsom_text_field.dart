import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key, required this.hint, required this.controller});
  final String hint;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CusomTextFieldState();
}

class _CusomTextFieldState extends State<CustomTextField> {
  TextEditingController fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        prefix: const SizedBox(
          width: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 12, 154, 219),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFEDEDED),
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 12, 154, 219),
        ),
      ),
    );
  }
}
