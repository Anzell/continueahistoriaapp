import 'package:continueahistoriaapp/data/datasources/remote/auth_remote_ds.dart';
import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
import 'package:continueahistoriaapp/di/injector.dart';

class DatasourcesInjector {
  static Future<void> inject() async {
    getIt.registerFactory<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(httpClient: getIt(), hive: getIt()));
    getIt.registerFactory<RoomRemoteDs>(() => RoomRemoteDsImpl(httpClient: getIt(), hive: getIt()));
  }
}