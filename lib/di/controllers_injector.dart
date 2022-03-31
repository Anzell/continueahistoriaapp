import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/auth/controllers/auth_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';

class ControllersInjector {
  static Future<void> inject() async {
    getIt.registerFactory<AuthController>(
      () => AuthController(
        signUpConverter: getIt(),
        signInUseCase: getIt(),
        signInConverter: getIt(),
        signUpUseCase: getIt(),
        autoLoginUsecase: getIt(),
      ),
    );
    getIt.registerLazySingleton<AppController>(() => AppController());
    getIt.registerFactory<RoomsController>(() => RoomsController(
      getRoomsByPlayerIdConverter: getIt(),
      getPlayerRoomsUsecase: getIt(),
    ));
  }
}
