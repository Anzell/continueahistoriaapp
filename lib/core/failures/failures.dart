import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  @override
  List<Object?> get props => [];

}
class ServerFailure extends Failure{}
class UsernameAlreadyRegisteredFailure extends Failure{}
class EmailAlreadyRegisteredFailure extends Failure{}
class InvalidCredentialsFailure extends Failure{}
class AccessDeniedFailure extends Failure{}
class ValidationFailure extends Failure{
  final String message;

  ValidationFailure({required this.message});
}