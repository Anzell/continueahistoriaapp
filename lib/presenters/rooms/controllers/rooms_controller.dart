import 'dart:async';

import 'package:continueahistoriaapp/core/helpers/failure_helper.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/add_player.dart';
import 'package:continueahistoriaapp/domain/usecases/room/create_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';
import 'package:continueahistoriaapp/domain/usecases/room/listen_room_by_id.dart';
import 'package:continueahistoriaapp/domain/usecases/room/lock_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/send_phrase.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/add_player_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/create_room_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/listen_room_by_id_converter.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/room_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../core/failures/failures.dart';
import '../../../domain/entities/game_room.dart';
import '../converters/send_phrase_converter.dart';

part 'rooms_controller.g.dart';

class RoomsController = _RoomsControllerBase with _$RoomsController;

abstract class _RoomsControllerBase with Store {
  final GetRoomsByPlayerIdConverter getRoomsByPlayerIdConverter;
  final GetPlayerRoomsUsecase getPlayerRoomsUsecase;
  final ListenRoomByIdUsecase listenRoomByIdUsecase;
  final ListenRoomByIdConverter listenRoomByIdConverter;
  final SendPhraseConverter sendPhraseConverter;
  final SendPhraseUseCase sendPhraseUseCase;
  final RoomConverter roomConverter;
  final CreateRoomConverter createRoomConverter;
  final CreateRoomUsecase createRoomUsecase;
  final AddPlayerConverter addPlayerConverter;
  final AddPlayerInRoomUsecase addPlayerInRoomUsecase;
  final LockRoomUsecase lockRoomUsecase;

  _RoomsControllerBase({
    required this.getPlayerRoomsUsecase,
    required this.getRoomsByPlayerIdConverter,
    required this.listenRoomByIdUsecase,
    required this.listenRoomByIdConverter,
    required this.sendPhraseConverter,
    required this.sendPhraseUseCase,
    required this.createRoomConverter,
    required this.roomConverter,
    required this.createRoomUsecase,
    required this.addPlayerConverter,
    required this.addPlayerInRoomUsecase,
    required this.lockRoomUsecase,
  });

  @observable
  Option<String> failure = const None();

  @action
  void _setFailure(Failure failure) => this.failure = optionOf(FailureHelper.mapFailureToMessage(failure));

  @observable
  List<ResumedGameRoom> listResumedRooms = [];

  @action
  Future<void> getRoomsByPlayerId({String? userId}) async {
    failure = const None();
    final completer = Completer();
    Future(() {
      final converterResult = getRoomsByPlayerIdConverter(GetRoomsByPlayerIdConverterParams(userId: userId));
      converterResult.fold((failure) {
        _setFailure(failure);
        completer.complete();
      }, (convertedObject) async {
        final usecaseResult = await getPlayerRoomsUsecase(GetPlayerRoomsUsecaseParams(userId: convertedObject.userId));
        usecaseResult.fold((failure) {
          _setFailure(failure);
          completer.complete();
        }, (list) {
          listResumedRooms = list;
          completer.complete();
        });
      });
    });
    await completer.future;
  }

  @observable
  GameRoom? listeningRoom;

  @action
  void listenRoomById({String? roomId}) {
    final converterResult = listenRoomByIdConverter(ListenRoomByIdConverterParams(roomId: roomId));
    converterResult.fold(_setFailure, (converted) {
      listenRoomByIdUsecase(ListenRoomByIdUsecaseParams(roomId: converted.roomId)).listen((event) {
        event.fold(_setFailure, (room) => listeningRoom = room);
      });
    });
  }

  @action
  Future<void> sendPhrase({String? roomId, String? userId, String? phrase}) async {
    failure = const None();
    final completer = Completer();
    Future(() {
      final converterResult =
          sendPhraseConverter(SendPhraseConverterParams(userId: userId, phrase: phrase, roomId: roomId));
      converterResult.fold((failure) {
        _setFailure(failure);
        completer.complete();
      }, (convertedObject) async {
        final usecaseResult = await sendPhraseUseCase(SendPhraseUseCaseParams(
            userId: convertedObject.userId, phrase: convertedObject.phrase, roomId: convertedObject.roomId));
        usecaseResult.fold((failure) {
          _setFailure(failure);
          completer.complete();
        }, (_) => completer.complete());
      });
    });
    await completer.future;
  }

  @action
  Future<void> createRoom({String? name, String? userId}) async {
    failure = const None();
    final completer = Completer();
    Future(() {
      final roomConverterResult = roomConverter(RoomConverterParams(name: name));
      roomConverterResult.fold((failure) {
        _setFailure(failure);
        completer.complete();
      }, (convertedRoomObject) {
        final createRoomConverterResult = createRoomConverter(
          CreateRoomConverterParams(userId: userId, roomData: convertedRoomObject.gameRoom),
        );
        createRoomConverterResult.fold((failure) {
          _setFailure(failure);
          completer.complete();
        }, (convertedCreateRoomObject) async {
          final usecaseResult = await createRoomUsecase(
            CreateRoomUsecaseParams(
              userId: convertedCreateRoomObject.userId,
              roomData: convertedCreateRoomObject.roomData,
            ),
          );
          usecaseResult.fold((failure) {
            _setFailure(failure);
            completer.complete();
          }, (_) => completer.complete());
        });
      });
    });
    await completer.future;
  }

  @action
  Future<void> addPlayerInRoom({String? username, String? roomId}) async {
    failure = const None();
    final completer = Completer();
    Future(() {
      final converterResult = addPlayerConverter(AddPlayerConverterParams(roomId: roomId, username: username));
      converterResult.fold((failure) {
        _setFailure(failure);
        completer.complete();
      }, (convertedObject) async {
        final usecaseResult = await addPlayerInRoomUsecase(
            AddPlayerInRoomUsecaseParams(roomId: convertedObject.roomId, username: convertedObject.username));
        usecaseResult.fold((failure) {
          _setFailure(failure);
          completer.complete();
        }, (_) => completer.complete());
      });
    });
    await completer.future;
  }

  @action
  Future<void> lockRoom({required String roomId, required String userId}) async {
    failure = const None();
    final result = await lockRoomUsecase(LockRoomUsecaseParams(userId: userId, roomId: roomId));
    result.fold(_setFailure, (_) => _);
  }

}
