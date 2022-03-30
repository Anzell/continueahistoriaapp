import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUsecase implements FutureUseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  const AutoLoginUsecase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.tryAutoLogin();
  }

}