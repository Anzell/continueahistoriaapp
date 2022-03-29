import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dart:convert';

import 'room_remote_ds_test.mocks.dart';

@GenerateMocks([http.Client, HiveInterface, Box])
void main(){
  late MockClient mockClient;
  late MockHiveInterface mockHiveInterface;
  late RoomRemoteDsImpl roomRemoteDsImpl;

  setUp((){
    mockHiveInterface = MockHiveInterface();
    mockClient = MockClient();
    roomRemoteDsImpl = RoomRemoteDsImpl(httpClient: mockClient, hive: mockHiveInterface);
  });

  group("get player rooms", () {
    test("should return a valid array ResumedGameRoom if call to api is success", () async {
      final List<ResumedGameRoom> expected = [
        ResumedGameRoom(id: "validId1", phrasesNumber: 10, playersNumber: 10, title: "simpleTitle"),
        ResumedGameRoom(id: "validId2", phrasesNumber: 2, playersNumber: 2, title: "simpleTitle 2"),
      ];
      when(mockClient.get(any, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer validToken"
      })).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 200,
        "message": "sucesso na operação",
        "code": ServerCodes.success,
        "result": [
          {
            "id": "validId1", "phrasesNumber": 10, "playersNumber": 10, "title": "simpleTitle"
          },
          {
            "id": "validId2", "phrasesNumber": 2, "playersNumber": 2, "title": "simpleTitle 2"
          }
        ]
      }), 200));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.box(any)).thenAnswer((_) => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      final result = await roomRemoteDsImpl.getPlayerRooms(userId: "validId");
      expect(result, equals(expected));
    });

    test("should throw ServerException if call to api is fail", () async {
      when(mockClient.get(any, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer validToken"
      })).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "Erro",
        "code": ServerCodes.serverFailure,
        "result": {}
      }), 200));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.box(any)).thenAnswer((_) => mockHiveBox);
      when(mockHiveBox.get(any)).thenReturn("validToken");
      final result = roomRemoteDsImpl.getPlayerRooms(userId: "validId");;
      expect(result, throwsA(isA<ServerException>()));
    });

  });

}