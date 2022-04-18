import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/stream_usecases.dart';
import 'package:continueahistoriaapp/domain/repositories/server_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecases/future_usecases.dart';

class ListenServerFailuresUsecase implements StreamUseCase<ReceivedServerFailure, NoParams>{
  final ServerRepository repository;

  const ListenServerFailuresUsecase({required this.repository});

  @override
  Stream<Either<Failure, ReceivedServerFailure>> call(NoParams params) async* {
    final stream = repository.listenServerFailures();
    await for(final event in stream){
      yield event;
    }
  }

}