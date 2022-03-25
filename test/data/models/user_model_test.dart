import 'dart:convert';

import 'package:continueahistoriaapp/data/models/user_model.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main(){
  const userModel = UserModel(
    id: "testId",
    username: "testUsername",
    email: "email@email.com"
  );

  test("should be a Object of type UserEntity", () {
    expect(userModel, isA<UserEntity>());
  });

  test("should return a valid model from json ", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("user_model.json"));
    final result = UserModel.fromJson(jsonMap);
    expect(result, equals(userModel));
  });

  test("should return a json containing the proper data", () {
    final result = userModel.toJson();
    final expected = {
      "id": "testId",
      "username": "testUsername",
      "email": "email@email.com"
    };
    expect(result, equals(expected));
  });
}