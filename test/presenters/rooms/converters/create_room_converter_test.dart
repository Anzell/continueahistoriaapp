import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/create_room_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late CreateRoomConverter createRoomConverter;

  setUp(() {
    createRoomConverter = CreateRoomConverter();
  });

  test("should return converted object if data provided is valid", () {
    final roomData = GameRoom(name: "Era uma vez");
    final userId = "validId";
    final result = createRoomConverter(CreateRoomConverterParams(roomData: roomData, userId: userId));
    expect(result, equals(Right(CreateRoomConverted(roomData: roomData, userId: userId))));
  });

  test("should return left if data provided is invalid", () {
    late Either result;
    result = createRoomConverter(CreateRoomConverterParams(roomData: GameRoom(name: "Era uma vez")));
    expect(result, equals(Left(ValidationFailure(message: CreateRoomConverterErrorMessages.missingUser))));
    result = createRoomConverter(CreateRoomConverterParams(roomData: GameRoom(name: "Era uma vez"), userId: ""));
    expect(result, equals(Left(ValidationFailure(message: CreateRoomConverterErrorMessages.missingUser))));
    result = createRoomConverter(CreateRoomConverterParams( userId: "validId"));
    expect(result, equals(Left(ValidationFailure(message: CreateRoomConverterErrorMessages.missingRoomData))));
  });
}