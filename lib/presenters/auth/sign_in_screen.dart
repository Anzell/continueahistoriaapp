import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/auth/controllers/auth_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/rooms_list_screen.dart';
import 'package:continueahistoriaapp/presenters/widgets/icon_button.dart';
import 'package:continueahistoriaapp/presenters/widgets/input_form.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = getIt.get<AuthController>();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    _reactionFailureSetup(context);
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bem-Vindo de volta"),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Column(
                    children: [
                      CustomInputForm(
                        controller: emailController,
                        placeholder: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 10),
                      CustomInputForm(
                        controller: passwordController,
                        placeholder: "Senha",
                        prefixIcon: Icon(Icons.key),
                        secretText: true,
                      ),
                      SizedBox(height: 10),
                      StatefulBuilder(
                        builder: (context, setState) => _loading
                            ? CircularProgressIndicator()
                            : CustomIconButton(
                                icon: Icon(Icons.navigate_next),
                                backgroundColor: Colors.white,
                                onTap: () async {
                                  setState(() => _loading = true);
                                  final result = await _signIn();
                                  if (result != null) {
                                    final appController = getIt.get<AppController>();
                                    appController.setUser(result);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => RoomsListScreen()), (route) => false);
                                  }
                                  setState(() => _loading = false);
                                }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _reactionFailureSetup(BuildContext context) {
    reaction(
      (_) => authController.failure,
      (_) => authController.failure.map(
        (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }

  Future<UserEntity?> _signIn() async {
    return await authController.signIn(email: emailController.text, password: passwordController.text);
  }
}
