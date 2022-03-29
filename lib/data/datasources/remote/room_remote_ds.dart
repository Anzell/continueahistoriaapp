import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/mappers/resumed_game_room_mapper.dart';
import 'package:continueahistoriaapp/data/models/resumed_game_room_model.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/hive_constants.dart';
import '../../../core/constants/server_constants.dart';

abstract class RoomRemoteDs {
  Future<List<ResumedGameRoom>> getPlayerRooms({required String userId});
}

class RoomRemoteDsImpl implements RoomRemoteDs {
  final http.Client httpClient;
  final HiveInterface hive;

  RoomRemoteDsImpl({required this.httpClient, required this.hive});

  @override
  Future<List<ResumedGameRoom>> getPlayerRooms({required String userId}) async {
    final path = ServerConstants.url + ServerConstants.getRoomsOfPlayer + "/$userId";
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

  ResumedGameRoom parseResumedGameRoomModelToEntity(ResumedGameRoomModel model) => ResumedGameRoomMapper.modelToEntity(model);

  Future<String> _getAuthorizationToken() async => hive.box(HiveStaticBoxes.authorization).get(HiveStaticKeys.token);
}