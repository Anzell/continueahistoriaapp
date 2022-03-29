import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_player_rooms_test.mocks.dart';

@GenerateMocks([RoomRepository])
void main (){
  late MockRoomRepository mockRoomRepository;
  late GetPlayerRoomsUsecase getPlayerRoomsUsecase;

  setUp((){
    mockRoomRepository = MockRoomRepository();
    getPlayerRoomsUsecase = GetPlayerRoomsUsecase(repository: mockRoomRepository);
  });

  test("should return right with a list of resumed rooms if call to repository is success", () async {
    final List<ResumedGameRoom> expected = [
      ResumedGameRoom(id: "validId1", phrasesNumber: 10, playersNumber: 10, title: "simpleTitle"),
      ResumedGameRoom(id: "validId2", phrasesNumber: 2, playersNumber: 2, title: "simpleTitle 2"),
    ];
    when(mockRoomRepository.getPlayerRooms(userId: anyNamed("userId"))).thenAnswer((_) async => Right(expected));
    final result = await getPlayerRoomsUsecase( const GetPlayerRoomsUsecaseParams(userId: "anyId"));
    expect(result, equals(Right(expected)));
  });


  test("should return left with failure if call to repository is fail", () async {
    when(mockRoomRepository.getPlayerRooms(userId: anyNamed("userId"))).thenAnswer((_) async => Left(ServerFailure()));
    final result = await getPlayerRoomsUsecase( const GetPlayerRoomsUsecaseParams(userId: "anyId"));
    expect(result, equals(Left(ServerFailure())));
  });

  test("should test equatable working for params",() {
    const obj1 = GetPlayerRoomsUsecaseParams(userId: "id");
    const obj2 = GetPlayerRoomsUsecaseParams(userId: "id");
    expect(obj1, equals(obj2));
  });
}