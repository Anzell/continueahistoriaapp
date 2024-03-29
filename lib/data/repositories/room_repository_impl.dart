import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';
import '../../domain/entities/resumed_game_room.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDs datasource;

  RoomRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<ResumedGameRoom>>> getPlayerRooms({required String userId}) async {
    try {
      final response = await datasource.getPlayerRooms(userId: userId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<Either<Failure, GameRoom>> listenRoom({required String roomId}) async* {
    try {
      final stream = datasource.listenRoomUpdate(roomId: roomId);
      await for (final room in stream) {
        yield Right(room);
      }
    } catch (e) {
      yield Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, None>> sendPhrase({
    required String roomId,
    required String userId,
    required String phrase,
  }) async {
    try {
      await datasource.sendPhrase(roomId: roomId, userId: userId, phrase: phrase);
      return const Right(None());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, None>> createRoom({required GameRoom roomData, required String userId}) async {
    try {
      await datasource.createRoom(roomData: roomData, userId: userId);
      return const Right(None());
    } on ServerValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, None>> addPlayerInRoom({required String roomId, required String username}) async {
    try {
      await datasource.addPlayerInRoom(roomId: roomId, username: username);
      return const Right(None());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, None>> lockRoom({required String roomId, required String userId}) async {
    try {
      await datasource.lockRoom(roomId: roomId, userId: userId);
      return const Right(None());
    } catch(e) {
      return Left(ServerFailure());
    }
  }
}
