import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';

class SignInUseCase implements FutureUseCase<UserEntity, SignInUseCaseParams> {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(SignInUseCaseParams params) async {
    return await repository.signIn(email: params.email, password: params.password);
  }
}

class SignInUseCaseParams extends Equatable {
  final String email;
  final String password;

  const SignInUseCaseParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
