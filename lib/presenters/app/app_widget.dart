import 'package:continueahistoriaapp/presenters/auth/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black
        )
      ),
      home: HomeScreen(

      ),
    );
  }
}
