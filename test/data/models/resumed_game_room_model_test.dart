import 'dart:convert';

import 'package:continueahistoriaapp/data/models/resumed_game_room_model.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main(){
  final resumedGameRoomModel = ResumedGameRoomModel(
      id: "validRoomId",
      title: "Era uma vez",
    phrasesNumber: 21,
    playersNumber: 2
  );

  test("should be a Object of type ResumedGameRoom", () {
    expect(resumedGameRoomModel, isA<ResumedGameRoom>());
  });

  test("should return a valid model from json ", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("resumed_game_room_model.json"));
    final result = ResumedGameRoomModel.fromJson(jsonMap);
    expect(result, equals(resumedGameRoomModel));
  });

  test("should return a json containing the proper data", () {
    final result = resumedGameRoomModel.toJson();
    final expected = {
      "id": "validRoomId",
      "phrasesNumber": 21,
      "playersNumber": 2,
      "title": "Era uma vez"
    };
    expect(result, equals(expected));
  });
}