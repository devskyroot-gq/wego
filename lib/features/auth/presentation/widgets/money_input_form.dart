import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyInputForm extends StatelessWidget {
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
  final String? value;
  final void Function()? onTap;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;




  const MoneyInputForm({super.key, 
    required this.label, 
    this.hintText, 
    this.borderRadius, 
    this.fillColor, 
    this.focusBorderColor, 
    this.labelColor, 
    this.hintColor, 
    required this.controller, 
    this.keyboardType = TextInputType.number, 
    this.obscureText, 
    this.validator, 
    this.suffixIcon, 
    this.prefixIcon, 
    this.labelSize, 
    this.readOnly=false,
    this.value, this.onTap, this.onChanged, this.inputFormatters, });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
      inputFormatters: inputFormatters,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      style: TextStyle(fontSize: 18),
    );
  }
}
