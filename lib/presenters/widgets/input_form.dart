import 'package:continueahistoriaapp/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController controller;
  final Icon? prefixIcon;
  final String? placeholder;
  final bool? secretText;
  const CustomInputForm({Key? key,this.placeholder, required this.controller, this.prefixIcon, this.secretText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: prefixIcon,
        focusColor: AppColors.darkGreen,
        border: InputBorder.none
      ),
      controller: controller,
      obscureText: secretText ?? false,
    );
  }
}
