import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/listen_room_by_id_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ListenRoomByIdConverter listenRoomByIdConverter;

  setUp(() {
    listenRoomByIdConverter = ListenRoomByIdConverter();
  });

  test("should return right if data provided is valid", () {
    const expected = ListenRoomByIdConverted(roomId: "validId");
    final result = listenRoomByIdConverter(ListenRoomByIdConverterParams(roomId: expected.roomId));
    expect(result, equals(const Right(expected)));
  });

  test("should return left if data provided is invalid", () {
    Either result;
    result = listenRoomByIdConverter(ListenRoomByIdConverterParams());
    expect(result, equals(Left(ValidationFailure(message: ListenRoomByIdConverterErrorMessages.missingRoomId))));
    result = listenRoomByIdConverter(ListenRoomByIdConverterParams(roomId: ""));
    expect(result, equals(Left(ValidationFailure(message: ListenRoomByIdConverterErrorMessages.missingRoomId))));
  });
}