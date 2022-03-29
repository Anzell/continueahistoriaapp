import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
import 'package:continueahistoriaapp/data/repositories/room_repository_impl.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'room_repository_impl_test.mocks.dart';

@GenerateMocks([RoomRemoteDs])
void main(){
  late MockRoomRemoteDs mockRoomRemoteDs;
  late RoomRepositoryImpl roomRepositoryImpl;

  setUp((){
    mockRoomRemoteDs = MockRoomRemoteDs();
    roomRepositoryImpl = RoomRepositoryImpl(datasource: mockRoomRemoteDs);
  });

  group("get player rooms", () {
    test("should return right with array of list resumed rooms if call to datasource is success", () async {
      final List<ResumedGameRoom> expected = [
        ResumedGameRoom(id: "validId1", phrasesNumber: 10, playersNumber: 10, title: "simpleTitle"),
        ResumedGameRoom(id: "validId2", phrasesNumber: 2, playersNumber: 2, title: "simpleTitle 2"),
      ];
      when(mockRoomRemoteDs.getPlayerRooms(userId: anyNamed("userId"))).thenAnswer((_) async => expected);
      final result = await roomRepositoryImpl.getPlayerRooms(userId: "validId");
      expect(result, equals(Right(expected)));
    });

    test("should return left with failure if call to datasource is fail", () async {
      when(mockRoomRemoteDs.getPlayerRooms(userId: anyNamed("userId"))).thenThrow(ServerException());
      final result = await roomRepositoryImpl.getPlayerRooms(userId: "validId");
      expect(result, equals(Left(ServerFailure())));
    });
  });
}