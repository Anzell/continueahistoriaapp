import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/room/add_player.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_player_test.mocks.dart';

@GenerateMocks([RoomRepository])
void main() {
  late MockRoomRepository mockRoomRepository;
  late AddPlayerInRoomUsecase addPlayerInRoomUsecase;

  setUp(() {
    mockRoomRepository = MockRoomRepository();
    addPlayerInRoomUsecase = AddPlayerInRoomUsecase(repository: mockRoomRepository);
  });

  test("should return Right None if call to repository is success", () async {
    when(mockRoomRepository.addPlayerInRoom(roomId: anyNamed("roomId"), username: anyNamed("username")))
        .thenAnswer((_) async => Right(None()));
    final result = await addPlayerInRoomUsecase(AddPlayerInRoomUsecaseParams(
      username: "anzell",
      roomId: "valid",
    ));
    expect(result, equals(Right(None())));
  });

  test("should return Left if call to repository is fail", () async {
    when(mockRoomRepository.addPlayerInRoom(roomId: anyNamed("roomId"), username: anyNamed("username")))
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await addPlayerInRoomUsecase(AddPlayerInRoomUsecaseParams(
      username: "anzell",
      roomId: "valid",
    ));
    expect(result, equals(Left(ServerFailure())));
  });
}
