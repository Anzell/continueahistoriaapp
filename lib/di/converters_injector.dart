import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_in_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/add_player_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/create_room_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/listen_room_by_id_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/phrase_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/room_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/send_phrase_converter.dart';

import '../presenters/auth/converters/sign_up_converter.dart';

class ConvertersInjector {
  static Future<void> inject() async {
    getIt.registerFactory<SignInConverter>(() => SignInConverter());
    getIt.registerFactory<SignUpConverter>(() => SignUpConverter());
    getIt.registerFactory<ListenRoomByIdConverter>(() => ListenRoomByIdConverter());
    getIt.registerFactory<GetRoomsByPlayerIdConverter>(() => GetRoomsByPlayerIdConverter());
    getIt.registerFactory<SendPhraseConverter>(() => SendPhraseConverter());
    getIt.registerFactory<CreateRoomConverter>(() => CreateRoomConverter());
    getIt.registerFactory<RoomConverter>(() => RoomConverter());
    getIt.registerFactory<PhraseConverter>(() => PhraseConverter());
    getIt.registerFactory<AddPlayerConverter>(() => AddPlayerConverter());
  }
}
