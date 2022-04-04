import 'package:continueahistoriaapp/core/external/socket_service.dart';
import 'package:continueahistoriaapp/di/injector.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ExternalInjector {
  static Future<void> inject() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    getIt.registerFactory<HiveInterface>(() => Hive);
    getIt.registerFactory<http.Client>(() => http.Client());
    getIt.registerFactory<SocketService>(() => SocketServiceImpl(hive: getIt()));
  }
}