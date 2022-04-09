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
    return await repository.addPlayerInRoom(roomId: params.roomId, userId: params.userId);
  }
}

class AddPlayerInRoomUsecaseParams extends Equatable {
  final String userId;
  final String roomId;

  const AddPlayerInRoomUsecaseParams({required this.roomId, required this.userId});

  @override
  List<Object> get props => [userId, roomId];
}
