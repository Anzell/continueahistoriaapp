import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpUseCase implements FutureUseCase<None, SignUpUseCaseParams>{
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failure, None>> call(SignUpUseCaseParams params) async {
    return await repository.signUp(email: params.email, password: params.password, username: params.username);
  }

}



class SignUpUseCaseParams extends Equatable {
  final String email;
  final String password;
  final String username;

  const SignUpUseCaseParams({required this.email, required this.password, required this.username});

  @override
  List<Object?> get props => [email, password, username];
}