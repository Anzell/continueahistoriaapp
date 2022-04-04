import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class StreamUseCase<ReturnType, Params> {
  Stream<Either<Failure, ReturnType>> call(Params params);
}
