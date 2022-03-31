import 'dart:convert';

import 'package:continueahistoriaapp/data/models/phrase_model.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main () {
  final phraseModel = PhraseModel(
    phrase: "era uma vez",
    sendAt: DateTime(2021,10,10),
    senderId: "validId"
  );

  test("should be a Object of type Phrase", () {
    expect(phraseModel, isA<Phrase>());
  });

  test("should return a valid model from json ", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("phrase_model.json"));
    final result = PhraseModel.fromJson(jsonMap);
    expect(result, equals(phraseModel));
  });

  test("should return a json containing the proper data", () {
    final result = phraseModel.toJson();
    final expected = {
      "phrase": "era uma vez",
      "senderId": "validId",
      "sendAt": 1633834800000
    };
    expect(result, equals(expected));
  });
}