import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ServerRepository{
  Stream<Either<Failure, ReceivedServerFailure>> listenServerFailures();
}