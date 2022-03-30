import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Color backgroundColor;
  final Function() onTap;
  const CustomIconButton({Key? key, required this.icon, required this.backgroundColor, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: Material(
        shadowColor: Colors.black,
        elevation: 2,
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: onTap,
          child: icon,
        ),
      ),
    );
  }
}
