import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, None>> signUp({required String email, required String password, required String username});
  Future<Either<Failure, UserEntity>> signIn({required String email, required String password});
  Future<Either<Failure, UserEntity>> tryAutoLogin();
}