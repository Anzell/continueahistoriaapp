import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GetRoomsByPlayerIdConverter getRoomsByPlayerIdConverter;
  
  setUp((){
    getRoomsByPlayerIdConverter = GetRoomsByPlayerIdConverter();
  });
  
  test("should return valid object if data provided is valid", () {
    final userId = "validId";
    final result = getRoomsByPlayerIdConverter(GetRoomsByPlayerIdConverterParams(userId: userId));
    expect(result, equals(Right(GetRoomsByPlayerIdConverted(userId: userId))));
  });

  test("should return error message if data provided is invalid", () {
    Either result;
    result = getRoomsByPlayerIdConverter(GetRoomsByPlayerIdConverterParams());
    expect(result, equals(Left(ValidationFailure(message: GetRoomsByPlayerIdConverterErrorMessages.missingUserId))));
    result = getRoomsByPlayerIdConverter(GetRoomsByPlayerIdConverterParams(userId: ""));
    expect(result, equals(Left(ValidationFailure(message: GetRoomsByPlayerIdConverterErrorMessages.missingUserId))));
  });
}