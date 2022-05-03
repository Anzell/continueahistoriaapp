import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/room/add_player.dart';
import 'package:continueahistoriaapp/domain/usecases/room/lock_room.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_player_test.mocks.dart';

@GenerateMocks([RoomRepository])
void main() {
  late MockRoomRepository mockRoomRepository;
  late LockRoomUsecase lockRoomUsecase;

  setUp(() {
    mockRoomRepository = MockRoomRepository();
    lockRoomUsecase = LockRoomUsecase(repository: mockRoomRepository);
  });

  test("should return Right None if call to repository is success", () async {
    when(mockRoomRepository.lockRoom(roomId: anyNamed("roomId"), userId: anyNamed("userId")))
        .thenAnswer((_) async => Right(None()));
    final result = await lockRoomUsecase(LockRoomUsecaseParams(
      userId: "anzell",
      roomId: "valid",
    ));
    expect(result, equals(Right(None())));
  });

  test("should return Left if call to repository is fail", () async {
    when(mockRoomRepository.lockRoom(roomId: anyNamed("roomId"), userId: anyNamed("userId")))
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await lockRoomUsecase(LockRoomUsecaseParams(
      userId: "anzell",
      roomId: "valid",
    ));
    expect(result, equals(Left(ServerFailure())));
  });
}
