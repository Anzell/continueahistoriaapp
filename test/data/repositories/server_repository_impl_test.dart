import 'package:continueahistoriaapp/core/external/socket_service.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/data/repositories/server_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../datasources/remote/room_remote_ds_test.mocks.dart';

@GenerateMocks([SocketService])
void main(){
  late MockSocketService mockSocketService;
  late ServerRepositoryImpl serverRepositoryImpl;

  setUp((){
    mockSocketService = MockSocketService();
    serverRepositoryImpl = ServerRepositoryImpl(service: mockSocketService);
  });

  group("listen server failures", () {
    test("should emit valid Failures from server and return on Stream", () {
      final emit1 = ReceivedServerFailure(message: "erro");
      when(mockSocketService.eventListener(event: anyNamed("event"))).thenAnswer((_) async* {
        yield {"codeStatus":400,"message":"erros","result":{},"code":"validation_error"};
      });
      expect(serverRepositoryImpl.listenServerFailures(), emitsInOrder([Right(emit1), emitsDone]));
    });

    test("should emit another failure if stream is fail", (){
      expect(serverRepositoryImpl.listenServerFailures(), emitsInOrder([Left(ServerFailure()), emitsDone]));
    });
  });
}