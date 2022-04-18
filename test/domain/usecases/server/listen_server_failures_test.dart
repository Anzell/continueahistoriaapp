import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/repositories/server_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/server/listen_server_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_server_failures_test.mocks.dart';

@GenerateMocks([ServerRepository])
void main() {
  late MockServerRepository mockServerRepository;
  late ListenServerFailuresUsecase listenServerFailuresUsecase;

  setUp(() {
    mockServerRepository = MockServerRepository();
    listenServerFailuresUsecase= ListenServerFailuresUsecase(repository: mockServerRepository);
  });

  test("should return valid server Failures if call to repository is success", () {
    final emit1 = ReceivedServerFailure(message: "erro");
    when(mockServerRepository.listenServerFailures()).thenAnswer((_) async* {
      yield Right(ReceivedServerFailure(message: "erro tenso"));
    });
    expect(listenServerFailuresUsecase(NoParams()), emitsInOrder([Right(emit1), emitsDone]));
  });
}