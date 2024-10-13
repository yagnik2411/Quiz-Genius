import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/colors.dart';

class CustomTextForm extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final bool obscureText;
  final Icon? icon;
  final IconButton? suffixIcon;
  //constructor with named parameter
  const CustomTextForm(
      {super.key,
      required this.controller,
      this.keyboard,
      this.hintText,
      this.obscureText = false,
      required this.validator,
      this.icon,
      this.suffixIcon,
      required this.labelText,
      this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator,
        obscureText: obscureText,
        cursorColor: MyColors.darkCyan,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.midLime,
          labelText: labelText,
          labelStyle: labelStyle,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: const Color(0xff909090)),
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: MyColors.darkCyan,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: MyColors.darkCyan,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: MyColors.darkCyan,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: MyColors.darkCyan,
              )),
        ));
  }
}
