import 'package:continueahistoriaapp/data/repositories/auth_repository_impl.dart';
import 'package:continueahistoriaapp/data/repositories/room_repository_impl.dart';
import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';

class RepositoriesInjector {
  static Future<void> inject() async {
    getIt.registerFactory<RoomRepository>(() => RoomRepositoryImpl(datasource: getIt()));
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(datasource: getIt()));
  }
}