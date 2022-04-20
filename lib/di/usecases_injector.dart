import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/auto_login.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_in.dart';
import 'package:continueahistoriaapp/domain/usecases/room/add_player.dart';
import 'package:continueahistoriaapp/domain/usecases/room/create_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';
import 'package:continueahistoriaapp/domain/usecases/room/listen_room_by_id.dart';
import 'package:continueahistoriaapp/domain/usecases/room/send_phrase.dart';
import 'package:continueahistoriaapp/domain/usecases/server/listen_server_failures.dart';

import '../domain/usecases/auth/sign_up.dart';

class UsecasesInjector {
  static Future<void> inject() async {
    getIt.registerFactory<SignInUseCase>(() => SignInUseCase(repository: getIt()));
    getIt.registerFactory<SignUpUseCase>(() => SignUpUseCase(repository: getIt()));
    getIt.registerFactory<GetPlayerRoomsUsecase>(() => GetPlayerRoomsUsecase(repository: getIt()));
    getIt.registerFactory<AutoLoginUsecase>(() => AutoLoginUsecase(repository: getIt()));
    getIt.registerFactory<ListenRoomByIdUsecase>(() => ListenRoomByIdUsecase(repository: getIt()));
    getIt.registerFactory<SendPhraseUseCase>(() => SendPhraseUseCase(repository: getIt()));
    getIt.registerFactory<CreateRoomUsecase>(() => CreateRoomUsecase(repository: getIt()));
    getIt.registerFactory<AddPlayerInRoomUsecase>(() => AddPlayerInRoomUsecase(repository: getIt()));
    getIt.registerFactory<ListenServerFailuresUsecase>(() => ListenServerFailuresUsecase(repository: getIt()));
  }
}
