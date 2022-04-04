import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:dartz/dartz.dart';

abstract class RoomRepository {
  Future<Either<Failure, List<ResumedGameRoom>>> getPlayerRooms({required String userId});
  Stream<Either<Failure, GameRoom>> listenRoom({required String roomId});
}