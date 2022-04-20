import 'dart:async';

import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../services/service.dart';
import '../constants/hive_constants.dart';

abstract class SocketService implements Service {
  void emitEvent({required dynamic data});
  Stream<dynamic> eventListener({required String event});
}

class SocketServiceImpl implements SocketService {
  final HiveInterface hive;

  late Socket _socket;

  SocketServiceImpl({required this.hive});

  @override
  Stream<dynamic> eventListener({required String event}) {
    final controller = StreamController();
    _socket.on(event, (data) {
      controller.add(data);
    });
    return controller.stream;
  }

  @override
  Future<void> init() async {
    _socket = io(ServerConstants.url, OptionBuilder().setTransports(["websocket"]).setExtraHeaders({
      "Authorization": "Bearer ${await _getAuthorizationToken()}"
    }).build());
  }

  Future<String> _getAuthorizationToken() async {
    final box = await hive.openBox(HiveStaticBoxes.authorization);
    final token = await box.get(HiveStaticKeys.token);
    await box.close();
    return token;
  }

  @override
  void emitEvent({required data}) {
    _socket.emit("message", data);
  }

}