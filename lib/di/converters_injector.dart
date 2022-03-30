import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_in_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';

import '../presenters/auth/converters/sign_up_converter.dart';

class ConvertersInjector {
  static Future<void> inject() async {
    getIt.registerFactory<SignInConverter>(() => SignInConverter());
    getIt.registerFactory<SignUpConverter>(() => SignUpConverter());
    getIt.registerFactory<GetRoomsByPlayerIdConverter>(() => GetRoomsByPlayerIdConverter());
  }
}