import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:dartz/dartz.dart';

abstract class RoomRepository {
  Future<Either<Failure, List<ResumedGameRoom>>> getPlayerRooms({required String userId});
  Stream<Either<Failure, GameRoom>> listenRoom({required String roomId});
  Future<Either<Failure, None>> sendPhrase({required String roomId, required String userId, required String phrase});
  Future<Either<Failure, None>> createRoom({required GameRoom roomData, required String userId});
}