import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/room_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RoomConverter converter;

  setUp(() {
    converter = RoomConverter();
  });

  test("should return right if data provided is valid", () {
    final expected = RoomConverted(
      gameRoom: GameRoom(name: "Era uma vez"),
    );
    final result = converter(RoomConverterParams(name: "Era uma vez"));
    expect(result, equals(Right(expected)));
  });

  test("should return left if data provided is invalid", () {
    Either result;
    result = converter(RoomConverterParams());
    expect(result, equals(Left(ValidationFailure(message: RoomConverterErrorMessages.missingName))));
    result = converter(RoomConverterParams(name: ""));
    expect(result, equals(Left(ValidationFailure(message: RoomConverterErrorMessages.missingName))));
    result = converter(RoomConverterParams(name: "Era uma vez", history: [null]));
    expect(result, equals(Left(ValidationFailure(message: RoomConverterErrorMessages.invalidHistory))));
    result = converter(RoomConverterParams(name: "Era uma vez", playerIds: [null]));
    expect(result, equals(Left(ValidationFailure(message: RoomConverterErrorMessages.invalidPlayersData))));
    result = converter(RoomConverterParams(name: "Era uma vez", adminsIds: [null]));
    expect(result, equals(Left(ValidationFailure(message: RoomConverterErrorMessages.invalidAdminsData))));
  });
}
