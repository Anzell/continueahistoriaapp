import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_in.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';

import '../domain/usecases/auth/sign_up.dart';

class UsecasesInjector{
  static Future<void> inject() async {
    getIt.registerFactory<SignInUseCase>(() => SignInUseCase(repository: getIt()));
    getIt.registerFactory<SignUpUseCase>(() => SignUpUseCase(repository: getIt()));
    getIt.registerFactory<GetPlayerRoomsUsecase>(() => GetPlayerRoomsUsecase(repository: getIt()));
  }
}