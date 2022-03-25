import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class FutureUseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}