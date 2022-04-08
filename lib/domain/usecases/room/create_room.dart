import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateRoomUsecase implements FutureUseCase<None, CreateRoomUsecaseParams>{
  final RoomRepository repository;

  const CreateRoomUsecase({required this.repository});

  @override
  Future<Either<Failure, None>> call(CreateRoomUsecaseParams params) async {
    return await repository.createRoom(roomData: params.roomData, userId: params.userId);
  }

}

class CreateRoomUsecaseParams extends Equatable {
  final GameRoom roomData;
  final String userId;

  const CreateRoomUsecaseParams({required this.userId, required this.roomData});

  @override
  List<Object> get props => [roomData, userId];
}