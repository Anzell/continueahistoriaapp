import 'dart:async';

import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../constants/hive_constants.dart';

abstract class SocketService {
  Future<void> initSocket();
  Stream<dynamic> eventListener({required String event});
}

class SocketServiceImpl implements SocketService {
  final HiveInterface hive;

  late Socket _socket;

  SocketServiceImpl({required this.hive});

  @override
  Stream<dynamic> eventListener({required String event}) {
    final controller = StreamController();
    _socket.on(event, (data) => controller.add(data));
    return controller.stream;
  }

  @override
  Future<void> initSocket() async {
    _socket = io(ServerConstants.url, OptionBuilder().setExtraHeaders({
      "Authorization": "Bearer ${await _getAuthorizationToken()}"
    }));
  }

  Future<String> _getAuthorizationToken() async {
    final box = await hive.openBox(HiveStaticBoxes.authorization);
    final token = await box.get(HiveStaticKeys.token);
    await box.close();
    return token;
  }

}