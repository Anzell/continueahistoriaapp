import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';

abstract class RoomRemoteDs {
  Future<List<ResumedGameRoom>> getPlayerRooms({required String userId});
}