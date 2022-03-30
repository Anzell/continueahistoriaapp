import 'package:continueahistoriaapp/di/controllers_injector.dart';
import 'package:continueahistoriaapp/di/converters_injector.dart';
import 'package:continueahistoriaapp/di/datasources_injector.dart';
import 'package:continueahistoriaapp/di/external_injector.dart';
import 'package:continueahistoriaapp/di/repositories_injector.dart';
import 'package:continueahistoriaapp/di/usecases_injector.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  static Future<void> inject() async {
    await Future.wait([
      ExternalInjector.inject(),
      DatasourcesInjector.inject(),
      RepositoriesInjector.inject(),
      UsecasesInjector.inject(),
      ConvertersInjector.inject(),
      ControllersInjector.inject(),
    ]);
  }
}