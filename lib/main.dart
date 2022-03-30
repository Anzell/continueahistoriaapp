import 'package:continueahistoriaapp/di/injector.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.inject();
}
