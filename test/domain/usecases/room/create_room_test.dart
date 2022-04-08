import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/room/create_room.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_room_test.mocks.dart';

@GenerateMocks([RoomRepository])
void main() {
  late MockRoomRepository mockRoomRepository;
  late CreateRoomUsecase createRoomUsecase;

  setUp((){
    mockRoomRepository= MockRoomRepository();
    createRoomUsecase = CreateRoomUsecase(repository: mockRoomRepository);
  });

  test("should return right if call to repository is success", () async {
    final roomData = GameRoom(name: "Era uma vez");
    final userId = "validId";
    when(mockRoomRepository.createRoom(roomData: anyNamed('roomData'), userId: anyNamed("userId")))
        .thenAnswer((_) async => Right(None()));
    final result = await createRoomUsecase(CreateRoomUsecaseParams(roomData: roomData, userId: userId));
    expect(result, equals(Right(None())));
  });

  test("should return left if call to repository is fail", () async {
    final roomData = GameRoom(name: "Era uma vez");
    final userId = "validId";
    when(mockRoomRepository.createRoom(roomData: anyNamed('roomData'), userId: anyNamed("userId")))
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await createRoomUsecase(CreateRoomUsecaseParams(roomData: roomData, userId: userId));
    expect(result, equals(Left(ServerFailure())));
  });}