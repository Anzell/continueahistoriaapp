import 'dart:convert';

import 'package:continueahistoriaapp/data/models/game_room_model.dart';
import 'package:continueahistoriaapp/data/models/phrase_model.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final gameRoomModel = GameRoomModel(
      id: "validId",
      name: "era uma vez",
      playersIds: ["player1"],
      adminsIds: ["admin1"],
      history: [
      PhraseModel(
      phrase: "era uma vez",
      senderId: "validId",
      sendAt: DateTime(2021,10,10)
      )
      ],
      someoneIsTapping: false,
      lastTappedId: "admin1"
  );

  test("should be a Object of type Phrase", () {
    expect(gameRoomModel, isA<GameRoom>());
  });

  test("should return a valid model from json ", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("game_room_model.json"));
    final result = GameRoomModel.fromJson(jsonMap);
    expect(result, equals(gameRoomModel));
  });

  test("should return a json containing the proper data", () {
    final result = gameRoomModel.toJson();
    final expected = {
      "id": "validId",
      "name": "era uma vez",
      "playersIds": ["player1"],
      "adminsIds": ["admin1"],
      "history": [
        {
          "phrase": "era uma vez",
          "senderId": "validId",
          "sendAt": 1633834800000
        }
      ],
      "someoneIsTapping": false,
      "lastTappedId": "admin1"
    };
    expect(result, equals(expected));
  });
}