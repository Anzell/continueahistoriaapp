import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';
import 'package:continueahistoriaapp/domain/usecases/room/listen_room_by_id.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rooms_controller_test.mocks.dart';

@GenerateMocks([GetPlayerRoomsUsecase, ListenRoomByIdUsecase])
void main() {
  late MockGetPlayerRoomsUsecase mockGetPlayerRoomsUsecase;
  late GetRoomsByPlayerIdConverter getRoomsByPlayerIdConverter;
  late RoomsController roomsController;
  late MockListenRoomByIdUsecase mockListenRoomByIdUsecase;

  setUp(() {
    mockGetPlayerRoomsUsecase = MockGetPlayerRoomsUsecase();
    getRoomsByPlayerIdConverter = GetRoomsByPlayerIdConverter();
    mockListenRoomByIdUsecase = MockListenRoomByIdUsecase();
    roomsController = RoomsController(
      getPlayerRoomsUsecase: mockGetPlayerRoomsUsecase,
      getRoomsByPlayerIdConverter: GetRoomsByPlayerIdConverter(),
      listenRoomByIdUsecase: mockListenRoomByIdUsecase,
    );
  });

  group("get rooms by player id", () {
    test("should return and set a valid rooms list of a player provided", () async {
      final expected = [ResumedGameRoom(id: "validId1", phrasesNumber: 10, playersNumber: 2, title: "Era uma vez")];
      when(mockGetPlayerRoomsUsecase(any)).thenAnswer((_) async => Right(expected));
      await roomsController.getRoomsByPlayerId(userId: "validId");
      expect(roomsController.listResumedRooms, equals(expected));
      expect(roomsController.failure.isNone(), equals(true));
    });

    test("should set a failure if data provided to converter is invalid", () async {
      when(mockGetPlayerRoomsUsecase(any)).thenAnswer((_) async => Right([]));
      await roomsController.getRoomsByPlayerId(userId: "");
      expect(roomsController.listResumedRooms, equals([]));
      expect(roomsController.failure.isNone(), equals(false));
    });

    test("should set a failure if call to usecase is fail", () async {
      when(mockGetPlayerRoomsUsecase(any)).thenAnswer((_) async => Left(ServerFailure()));
      await roomsController.getRoomsByPlayerId(userId: "validId");
      expect(roomsController.listResumedRooms, equals([]));
      expect(roomsController.failure.isNone(), equals(false));
    });
  });
}
