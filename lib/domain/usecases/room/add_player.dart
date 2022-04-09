import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddPlayerInRoomUsecase implements FutureUseCase<None, AddPlayerInRoomUsecaseParams> {
  final RoomRepository repository;

  const AddPlayerInRoomUsecase({required this.repository});

  @override
  Future<Either<Failure, None>> call(AddPlayerInRoomUsecaseParams params) async {
    return await repository.addPlayerInRoom(roomId: params.roomId, username: params.username);
  }
}

class AddPlayerInRoomUsecaseParams extends Equatable {
  final String username;
  final String roomId;

  const AddPlayerInRoomUsecaseParams({required this.roomId, required this.username});

  @override
  List<Object> get props => [username, roomId];
}
