import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class Converter<ReturnType, Params> {
  Either<ValidationFailure, ReturnType> call(Params params);
}