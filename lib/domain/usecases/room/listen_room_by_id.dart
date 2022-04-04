import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/stream_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ListenRoomByIdUsecase implements StreamUseCase<GameRoom, ListenRoomByIdUsecaseParams>{
  final RoomRepository repository;

  const ListenRoomByIdUsecase({required this.repository});

  @override
  Stream<Either<Failure, GameRoom>> call(ListenRoomByIdUsecaseParams params) async* {
    final stream = repository.listenRoom(roomId: params.roomId);
    await for(final room in stream){
      yield room;
    }
  }

}

class ListenRoomByIdUsecaseParams extends Equatable {
  final String roomId;

  const ListenRoomByIdUsecaseParams({required this.roomId});

  @override
  List<Object> get props => [roomId];
}