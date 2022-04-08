import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:continueahistoriaapp/core/external/socket_service.dart';
import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dart:convert';

import 'room_remote_ds_test.mocks.dart';

@GenerateMocks([http.Client, HiveInterface, Box, SocketService])
void main() {
  late MockClient mockClient;
  late MockSocketService mockSocket;
  late MockHiveInterface mockHiveInterface;
  late RoomRemoteDsImpl roomRemoteDsImpl;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockClient = MockClient();
    mockSocket = MockSocketService();
    roomRemoteDsImpl = RoomRemoteDsImpl(httpClient: mockClient, hive: mockHiveInterface, socketService: mockSocket);
    when(mockSocket.initSocket()).thenAnswer((_) async => Future.value());
  });

  group("get player rooms", () {
    test("should return a valid array ResumedGameRoom if call to api is success", () async {
      final List<ResumedGameRoom> expected = [
        ResumedGameRoom(id: "validId1", phrasesNumber: 10, playersNumber: 10, title: "simpleTitle"),
        ResumedGameRoom(id: "validId2", phrasesNumber: 2, playersNumber: 2, title: "simpleTitle 2"),
      ];
      when(mockClient.get(any, headers: {"Content-Type": "application/json", "Authorization": "Bearer validToken"}))
          .thenAnswer((_) async => http.Response(
              json.encode({
                "codeStatus": 200,
                "message": "sucesso na operação",
                "code": ServerCodes.success,
                "result": [
                  {"id": "validId1", "phrasesNumber": 10, "playersNumber": 10, "title": "simpleTitle"},
                  {"id": "validId2", "phrasesNumber": 2, "playersNumber": 2, "title": "simpleTitle 2"}
                ]
              }),
              200));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      final result = await roomRemoteDsImpl.getPlayerRooms(userId: "validId");
      expect(result, equals(expected));
    });

    test("should throw ServerException if call to api is fail", () async {
      when(mockClient.get(any, headers: {"Content-Type": "application/json", "Authorization": "Bearer validToken"}))
          .thenAnswer((_) async => http.Response(
              json.encode({"codeStatus": 400, "message": "Erro", "code": ServerCodes.serverFailure, "result": {}}),
              200));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      final result = roomRemoteDsImpl.getPlayerRooms(userId: "validId");
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group("room stream", () {
    test("should emit room updates", () {
      final emit1 = json.encode({
        "id": "validId",
        "name": "era uma vez",
        "playersIds": ["player1"],
        "adminsIds": ["admin1"],
        "history": [
          {"phrase": "era uma vez", "senderId": "validId", "sendAt": 1633834800000}
        ]
      });
      final emit2 = json.encode({
        "id": "validId",
        "name": "era uma vez",
        "playersIds": ["player1"],
        "adminsIds": ["admin1"],
        "history": [
          {"phrase": "era uma vez", "senderId": "validId", "sendAt": 1633834800000}
        ]
      });
      final mockHiveBox = MockBox();
      when(mockSocket.emitEvent(data: anyNamed("data"))).thenAnswer((_) async => null);
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn({
        "id": "validId"
      });
      when(mockSocket.eventListener(event: anyNamed("event"))).thenAnswer((_) async* {
        yield emit1;
        yield emit2;
      });
      expectLater(
          roomRemoteDsImpl.listenRoomUpdate(roomId: "validId"),
          emitsInOrder([
            GameRoom(
                id: "validId",
                name: "era uma vez",
                playersIds: ["player1"],
                adminsIds: ["admin1"],
                history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10))]),
            GameRoom(
                id: "validId",
                name: "era uma vez",
                playersIds: ["player1"],
                adminsIds: ["admin1"],
                history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10))])
          ]));
    });
  });
  
  group("send phrase", () {
    test("should call socketService and emit data", () async {
      when(mockSocket.emitEvent(data: anyNamed("data"))).thenAnswer((_) async => Future.value(null));
      await roomRemoteDsImpl.sendPhrase(roomId: "validId", userId: "validId", phrase: "era uma vez");
      verify(mockSocket.emitEvent(data: anyNamed("data"))).called(1);
    });
  });

  group("create room", () {
    test("should register a new room", () async {
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 200,
        "message": "sucesso na operação",
        "code": ServerCodes.success,
        "result": {}
      }), 200));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      const roomData = GameRoom(
        name: "Era uma vez"
      );
      const userId = "validId";
      await roomRemoteDsImpl.createRoom(roomData: roomData, userId: userId);
      verify(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).called(1);
    });

    test("should throw ValidationException if call to api is fail", () async {
      final messageExpected = "erro";
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": messageExpected,
        "code": ServerCodes.validationError,
        "result": {}
      }), 400));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      const roomData = GameRoom(
          name: "Era uma vez"
      );
      const userId = "validId";
      final result = roomRemoteDsImpl.createRoom(roomData: roomData, userId: userId);
      expect(result, throwsA(isA<ServerValidationException>()));
    });

    test("should throw ServerException if call to api is fail", () async {
      final messageExpected = "erro";
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": messageExpected,
        "code": ServerCodes.serverFailure,
        "result": {}
      }), 400));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      const roomData = GameRoom(
          name: "Era uma vez"
      );
      const userId = "validId";
      final result = roomRemoteDsImpl.createRoom(roomData: roomData, userId: userId);
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
