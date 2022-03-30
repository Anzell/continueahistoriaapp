import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
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
    }catch (e){
      return Left(ServerFailure());
    }
  }
}