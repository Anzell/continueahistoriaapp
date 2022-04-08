import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
import 'package:continueahistoriaapp/data/repositories/room_repository_impl.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
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
  
  group("listen room", () {
    test("should emit valid game rooms if datasource listener is active", () {
      final emit1 =  GameRoom(
          id: "validId",
          name: "era uma vez",
          playersIds: ["player1"],
          adminsIds: ["admin1"],
          history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10))]);
      final emit2 =  GameRoom(
          id: "validId",
          name: "era uma vez",
          playersIds: ["player1"],
          adminsIds: ["admin1"],
          history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10)), Phrase(phrase: "um cara que", senderId: "validId", sendAt: DateTime(2021,11,11))]);
      when(mockRoomRemoteDs.listenRoomUpdate(roomId: anyNamed("roomId"))).thenAnswer((_) async* {
        yield emit1;
        yield emit2;
      });
      expectLater(roomRepositoryImpl.listenRoom(roomId: "validId"), emitsInOrder([Right(emit1), Right(emit2)]));
    });

    test("should emit server failures if call to datasource throws error", () {
      final emit1 =  GameRoom(
          id: "validId",
          name: "era uma vez",
          playersIds: ["player1"],
          adminsIds: ["admin1"],
          history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10))]);
      when(mockRoomRemoteDs.listenRoomUpdate(roomId: anyNamed("roomId"))).thenAnswer((_) async* {
        yield emit1;
        throw ServerException();
      });
      expectLater(roomRepositoryImpl.listenRoom(roomId: "validId"), emitsInOrder([Right(emit1), Left(ServerFailure())]));
    });
  });

  group("send phrase", () {
    test("should return None if call to datasource is success", () async {
      when(mockRoomRemoteDs.sendPhrase(roomId: anyNamed("roomId"), userId: anyNamed("userId"), phrase: anyNamed("phrase"))).thenAnswer((_) async => Future.value(null));
      final result = await roomRepositoryImpl.sendPhrase(roomId: "valid", userId: "valid", phrase: "era uma vez");
      expect(result, equals(Right(None())));
    });

    test("should return ServerFailure if call to datasource is fail", () async {
      when(mockRoomRemoteDs.sendPhrase(roomId: anyNamed("roomId"), userId: anyNamed("userId"), phrase: anyNamed("phrase"))).thenThrow(ServerException());
      final result = await roomRepositoryImpl.sendPhrase(roomId: "valid", userId: "valid", phrase: "era uma vez");
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("create room", () {
    final roomData = GameRoom(name: "Era uma vez");
    final userId = "validId";

    test("should return None if call to datasource is success", () async {
      when(mockRoomRemoteDs.createRoom(roomData: anyNamed("roomData"), userId: anyNamed("userId"))).thenAnswer((_) async => Future.value(null));
      final result = await roomRepositoryImpl.createRoom(roomData: roomData, userId: userId);
      expect(result, equals(Right(None())));
    });

    test("should return None if call to datasource is fail", () async {
      when(mockRoomRemoteDs.createRoom(roomData: anyNamed("roomData"), userId: anyNamed("userId"))).thenThrow(ServerException());
      final result = await roomRepositoryImpl.createRoom(roomData: roomData, userId: userId);
      expect(result, equals(Left(ServerFailure())));
    });

    test("should return ValidationFailure if call to datasource is fail", () async {
      when(mockRoomRemoteDs.createRoom(roomData: anyNamed("roomData"), userId: anyNamed("userId"))).thenThrow(ServerValidationException(message: "erro"));
      final result = await roomRepositoryImpl.createRoom(roomData: roomData, userId: userId);
      expect(result, equals(Left(ValidationFailure(message: "erro"))));
    });
  });
}