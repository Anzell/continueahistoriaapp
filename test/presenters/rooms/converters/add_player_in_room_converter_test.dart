import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/add_player_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AddPlayerConverter addPlayerConverter;

  setUp(() {
    addPlayerConverter = AddPlayerConverter();
  });

  test("should return converted if data provided is valid", () {
    final result = addPlayerConverter(AddPlayerConverterParams(username: "anzell", roomId: "validId"));
    expect(result, equals(Right(AddPlayerConverted(roomId: "validId", username: "anzell"))));
  });

  test("should return ValidationFailure if data provided is invalid", () {
    Either result;
    result = addPlayerConverter(AddPlayerConverterParams(roomId: "validId"));
    expect(result, equals(Left(ValidationFailure(message: AddPlayerConverterErrorMessages.missingUser))));
    result = addPlayerConverter(AddPlayerConverterParams(roomId: "validId", username: ""));
    expect(result, equals(Left(ValidationFailure(message: AddPlayerConverterErrorMessages.missingUser))));
    result = addPlayerConverter(AddPlayerConverterParams(username: "anzell"));
    expect(result, equals(Left(ValidationFailure(message: AddPlayerConverterErrorMessages.missingRoomId))));
    result = addPlayerConverter(AddPlayerConverterParams(username: "anzell", roomId: ""));
    expect(result, equals(Left(ValidationFailure(message: AddPlayerConverterErrorMessages.missingUser))));
  });
}
