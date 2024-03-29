import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/auth/controllers/auth_controller.dart';
import 'package:continueahistoriaapp/presenters/auth/sign_in_screen.dart';
import 'package:continueahistoriaapp/presenters/rooms/rooms_list_screen.dart';
import 'package:continueahistoriaapp/presenters/widgets/icon_button.dart';
import 'package:continueahistoriaapp/presenters/widgets/input_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = getIt.get<AuthController>();
  bool _registering = false;
  bool _loadingPage = false;

  @override
  void initState() {
    super.initState();
    _tryAutoLogin();
  }

  Future<void> _tryAutoLogin() async {
    setState(() => _loadingPage = true);
    final result = await authController.tryAutoLogin();
    if (result != null) {
      getIt.get<AppController>().setUser(result);
      _goToRoomsScreen();
    }
    setState(() => _loadingPage = false);
  }

  @override
  Widget build(BuildContext context) {
    _failureReactionSetup();
    return Scaffold(
      body: _loadingPage
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Para começar, vamos fazer o seu cadastro"),
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
                              controller: usernameController,
                              prefixIcon: Icon(Icons.person),
                              placeholder: "Apelido",
                            ),
                            SizedBox(height: 10),
                            CustomInputForm(
                              controller: emailController,
                              prefixIcon: Icon(Icons.email),
                              placeholder: "Email",
                            ),
                            SizedBox(height: 10),
                            CustomInputForm(
                              controller: passwordController,
                              prefixIcon: Icon(Icons.key),
                              placeholder: "Senha",
                              secretText: true,
                            ),
                            SizedBox(height: 10),
                            _registering
                                ? CircularProgressIndicator()
                                : CustomIconButton(
                                    icon: Icon(Icons.navigate_next),
                                    backgroundColor: Colors.white,
                                    onTap: () async {
                                      setState(() => _registering = true);
                                      await _signUp();
                                      if (authController.failure.isNone()) {
                                        _goToSignInScreen();
                                      }
                                      setState(() => _registering = false);
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "já tem conta ?", style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: "Entrar",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen())),
                      ),
                    ]),
                  )
                ],
              ),
            ),
    );
  }

  _failureReactionSetup() {
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

  Future<void> _signUp() async {
    await authController.signUp(
      password: passwordController.text,
      email: emailController.text,
      username: usernameController.text,
    );
  }

  void _goToSignInScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  void _goToRoomsScreen() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RoomsListScreen()), (_) => false);
  }
}
