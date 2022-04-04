import 'dart:async';

import 'package:continueahistoriaapp/core/external/socket_service.dart';
import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/mappers/game_room_mapper.dart';
import 'package:continueahistoriaapp/data/mappers/resumed_game_room_mapper.dart';
import 'package:continueahistoriaapp/data/models/game_room_model.dart';
import 'package:continueahistoriaapp/data/models/resumed_game_room_model.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/hive_constants.dart';
import '../../../core/constants/server_constants.dart';

abstract class RoomRemoteDs {
  Future<List<ResumedGameRoom>> getPlayerRooms({required String userId});
  Stream<GameRoom> listenRoomUpdate({required String roomId});
}

class RoomRemoteDsImpl implements RoomRemoteDs {
  final http.Client httpClient;
  final HiveInterface hive;
  final SocketService socketService;

  RoomRemoteDsImpl({required this.httpClient, required this.hive, required this.socketService}){
    socketService.initSocket();
  }

  @override
  Future<List<ResumedGameRoom>> getPlayerRooms({required String userId}) async {
    final path = ServerConstants.url + ServerConstants.getRoomsOfPlayer + userId;
    final response = await httpClient.get(Uri.parse(path), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await _getAuthorizationToken()}",
    });
    if (json.decode(response.body)["code"] == ServerCodes.success) {
      final tempList = json.decode(response.body)["result"] as List;
      return tempList.map((e) => parseResumedGameRoomModelToEntity(ResumedGameRoomModel.fromJson(e))).toList();
    }
    throw ServerException();
  }

  ResumedGameRoom parseResumedGameRoomModelToEntity(ResumedGameRoomModel model) =>
      ResumedGameRoomMapper.modelToEntity(model);

  Future<String> _getAuthorizationToken() async {
    final box = await hive.openBox(HiveStaticBoxes.authorization);
    final token = await box.get(HiveStaticKeys.token);
    await box.close();
    return token;
  }

  @override
  Stream<GameRoom> listenRoomUpdate({required String roomId}) async* {
    final controller = StreamController<GameRoom>();
    socketService.eventListener(event: "updateRoom").listen((event) => controller.add(GameRoomMapper.modelToEntity(GameRoomModel.fromJson(event))));
    await for (final room in controller.stream) {
      yield room;
    }
  }

}
