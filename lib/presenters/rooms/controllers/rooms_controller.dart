import 'dart:async';

import 'package:continueahistoriaapp/core/helpers/failure_helper.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart';
import 'package:continueahistoriaapp/domain/usecases/room/listen_room_by_id.dart';
import 'package:continueahistoriaapp/presenters/rooms/converters/get_rooms_by_player_id_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../core/failures/failures.dart';

part 'rooms_controller.g.dart';

class RoomsController = _RoomsControllerBase with _$RoomsController;

abstract class _RoomsControllerBase with Store {
  final GetRoomsByPlayerIdConverter getRoomsByPlayerIdConverter;
  final GetPlayerRoomsUsecase getPlayerRoomsUsecase;
  final ListenRoomByIdUsecase listenRoomByIdUsecase;

  _RoomsControllerBase({
    required this.getPlayerRoomsUsecase,
    required this.getRoomsByPlayerIdConverter,
    required this.listenRoomByIdUsecase,
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


}