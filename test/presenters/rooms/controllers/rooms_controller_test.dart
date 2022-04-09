import 'package:continueahistoriaapp/core/constants/error_messages.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/create_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';
import 'package:continueahistoriaapp/domain/usecases/room/listen_room_by_id.dart';
import 'package:continueahistoriaapp/domain/usecases/room/send_phrase.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/create_room_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/listen_room_by_id_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/room_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/send_phrase_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rooms_controller_test.mocks.dart';

@GenerateMocks([GetPlayerRoomsUsecase, ListenRoomByIdUsecase, SendPhraseUseCase, CreateRoomUsecase])
void main() {
  late MockGetPlayerRoomsUsecase mockGetPlayerRoomsUsecase;
  late GetRoomsByPlayerIdConverter getRoomsByPlayerIdConverter;
  late ListenRoomByIdConverter listenRoomByIdConverter;
  late RoomsController roomsController;
  late SendPhraseConverter sendPhraseConverter;
  late MockSendPhraseUseCase mockSendPhraseUseCase;
  late MockListenRoomByIdUsecase mockListenRoomByIdUsecase;
  late MockCreateRoomUsecase mockCreateRoomUsecase;
  late CreateRoomConverter createRoomConverter;
  late RoomConverter roomConverter;

  setUp(() {
    mockGetPlayerRoomsUsecase = MockGetPlayerRoomsUsecase();
    getRoomsByPlayerIdConverter = GetRoomsByPlayerIdConverter();
    mockListenRoomByIdUsecase = MockListenRoomByIdUsecase();
    listenRoomByIdConverter = ListenRoomByIdConverter();
    sendPhraseConverter = SendPhraseConverter();
    createRoomConverter = CreateRoomConverter();
    roomConverter = RoomConverter();
    mockCreateRoomUsecase = MockCreateRoomUsecase();
    mockSendPhraseUseCase = MockSendPhraseUseCase();
    roomsController = RoomsController(
      getPlayerRoomsUsecase: mockGetPlayerRoomsUsecase,
      getRoomsByPlayerIdConverter: GetRoomsByPlayerIdConverter(),
      listenRoomByIdUsecase: mockListenRoomByIdUsecase,
      listenRoomByIdConverter: listenRoomByIdConverter,
      sendPhraseUseCase: mockSendPhraseUseCase,
      sendPhraseConverter: sendPhraseConverter,
      createRoomConverter: createRoomConverter,
      roomConverter: roomConverter,
      createRoomUsecase: mockCreateRoomUsecase,
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

  group("listen room by id", () {
    test("should emit a valid Room when call to usecase and converter are valid", () {
      final emit1 = GameRoom(
          id: "validId",
          name: "era uma vez",
          playersIds: ["player1"],
          adminsIds: ["admin1"],
          history: [Phrase(phrase: "era uma vez", senderId: "validId", sendAt: DateTime(2021, 10, 10))]);
      when(mockListenRoomByIdUsecase(any)).thenAnswer((_) async* {
        yield Right(emit1);
      });
      roomsController.listenRoomById(roomId: "validId");
      mobx.reaction((_) => roomsController.listeningRoom, (_) {
        expect(roomsController.listeningRoom, equals(emit1));
      });
    });

    test("should set a failure when call to converter is fail", () {
      roomsController.listenRoomById(roomId: "");
      mobx.reaction((_) => roomsController.failure, (_) {
        expect(roomsController.failure, equals(ListenRoomByIdConverterErrorMessages.missingRoomId));
      });
    });

    test("should set a failure when call to usecase is fail", () {
      when(mockListenRoomByIdUsecase(any)).thenAnswer((_) async* {
        yield Left(ServerFailure());
      });
      roomsController.listenRoomById(roomId: "validId");
      mobx.reaction((_) => roomsController.failure, (_) {
        expect(roomsController.failure, equals(ErrorMessages.serverFailure));
      });
    });
  });

  group("send phrase", () {
    test("should send phrase to the usecase sucessfully", () async {
      when(mockSendPhraseUseCase(any)).thenAnswer((_) async => Right(None()));
      final roomId = "validId";
      final userId = "validId";
      final phrase = "Era uma vez";
      await roomsController.sendPhrase(phrase: phrase, userId: userId, roomId: roomId);
      verify(mockSendPhraseUseCase(any)).called(1);
      expect(roomsController.failure, equals(None()));
    });

    test("should set failure if call to converter is fail", () async {
      when(mockSendPhraseUseCase(any)).thenAnswer((_) async => Right(None()));
      final roomId = "validId";
      final userId = "validId";
      final phrase = "frase invalida";
      await roomsController.sendPhrase(phrase: phrase, userId: userId, roomId: roomId);
      verifyNever(mockSendPhraseUseCase(any));
      expect(roomsController.failure, isA<Some>());
    });

    test("should set failure if call to usecase is fail", () async {
      when(mockSendPhraseUseCase(any)).thenAnswer((_) async => Left(ServerFailure()));
      final roomId = "validId";
      final userId = "validId";
      final phrase = "Era uma vez";
      await roomsController.sendPhrase(phrase: phrase, userId: userId, roomId: roomId);
      verify(mockSendPhraseUseCase(any)).called(1);
      expect(roomsController.failure, isA<Some>());
    });
  });

  group("create room", () {
    test("should call all steps to create the room", () async {
      when(mockCreateRoomUsecase(any)).thenAnswer((_) async => Right(None()));
      await roomsController.createRoom(name: "Era uma vez", userId: "validId");
      expect(roomsController.failure, equals(None()));
      verify(mockCreateRoomUsecase(any)).called(1);
    });

    test("should set a failure if call to roomConverter is fail", () async {
      when(mockCreateRoomUsecase(any)).thenAnswer((_) async => Right(None()));
      await roomsController.createRoom(name: "", userId: "validId");
      expect(roomsController.failure, isA<Some>());
      verifyNever(mockCreateRoomUsecase(any));
    });

    test("should set a failure if call to createRoomConverter is fail", () async {
      when(mockCreateRoomUsecase(any)).thenAnswer((_) async => Right(None()));
      await roomsController.createRoom(name: "Era uma vez", userId: "");
      expect(roomsController.failure, isA<Some>());
      verifyNever(mockCreateRoomUsecase(any));
    });
  });
}
