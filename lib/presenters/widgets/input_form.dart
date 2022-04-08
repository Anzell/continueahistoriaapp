import 'package:continueahistoriaapp/core/themes/app_colors.dart';
import 'package:continueahistoriaapp/presenters/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController controller;
  final Icon? prefixIcon;
  final String? placeholder;
  final bool? secretText;
  final Widget? suffixIconButton;
  const CustomInputForm({Key? key,this.placeholder, this.suffixIconButton, required this.controller, this.prefixIcon, this.secretText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: suffixIconButton,
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
