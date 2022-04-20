import 'dart:convert';

import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:continueahistoriaapp/core/external/socket_service.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/repositories/server_repository.dart';
import 'package:dartz/dartz.dart';

class ServerRepositoryImpl implements ServerRepository {
  final SocketService service;

  ServerRepositoryImpl({required this.service}){
    service.init().then((_) {});
  }

  @override
  Stream<Either<Failure, ReceivedServerFailure>> listenServerFailures() async* {
    try {
      final stream = service.eventListener(event: TypeSocketMessages.serverFailure);
      await for (final event in stream) {
        yield Right(ReceivedServerFailure(message: json.decode(event)["message"]));
      }
    } catch (e) {
      yield Left(ServerFailure());
    }
  }

}