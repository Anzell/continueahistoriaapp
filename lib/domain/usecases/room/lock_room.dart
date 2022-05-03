
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures/failures.dart';
import '../../../core/usecases/future_usecases.dart';
import '../../repositories/room_repository.dart';

class LockRoomUsecase implements FutureUseCase<None, LockRoomUsecaseParams> {
  final RoomRepository repository;

  const LockRoomUsecase({required this.repository});

  @override
  Future<Either<Failure, None>> call(LockRoomUsecaseParams params) async {
    return await repository.lockRoom(roomId: params.roomId, userId: params.userId);
  }
}

class LockRoomUsecaseParams extends Equatable {
  final String userId;
  final String roomId;

  const LockRoomUsecaseParams({required this.roomId, required this.userId});

  @override
  List<Object> get props => [userId, roomId];
}
