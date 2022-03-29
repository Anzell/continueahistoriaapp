import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetPlayerRoomsUsecase implements FutureUseCase<List<ResumedGameRoom>, GetPlayerRoomsUsecaseParams>{
  final RoomRepository repository;

  GetPlayerRoomsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<ResumedGameRoom>>> call(GetPlayerRoomsUsecaseParams params) async {
    return await repository.getPlayerRooms(userId: params.userId);
  }

}

class GetPlayerRoomsUsecaseParams extends Equatable {
  final String userId;

  const GetPlayerRoomsUsecaseParams({required this.userId});

  @override
  List<Object> get props => [userId];
}