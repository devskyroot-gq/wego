import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String label;
  final String? hintText;
  final double? borderRadius;
  final double? labelSize;
  final Color? fillColor;
  final Color? focusBorderColor;
  final Color? labelColor;
  final Color? hintColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final String? initialValue;
  final String? value;
  final void Function()? onTap;


  const InputForm({super.key, 
    required this.label, 
    this.hintText, 
    this.borderRadius, 
    this.fillColor, 
    this.focusBorderColor, 
    this.labelColor, 
    this.hintColor, 
    required this.controller, 
    this.keyboardType = TextInputType.text, 
    this.obscureText, 
    this.validator, 
    this.suffixIcon, 
    this.prefixIcon, 
    this.labelSize, 
    this.readOnly=false, 
    this.initialValue, 
    this.value, this.onTap, });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? Colors.grey.shade300,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(
          color: labelColor ?? Colors.grey,
          fontSize: labelSize ?? 18,
        ),
        hintStyle: TextStyle(
          color: hintColor ?? Colors.grey,
          fontSize: 18,
        ),
        label: Text(label),
        hintText: hintText,
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          borderSide: BorderSide(
            color: focusBorderColor ?? Colors.blue,
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          borderSide: BorderSide.none,
        ),
      ),
      controller: controller,
      readOnly: readOnly ?? false,
      onTap: onTap,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: validator,
      style: TextStyle(fontSize: 18),
    );
  }
}
