import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/data/datasources/remote/auth_remote_ds.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, UserEntity>> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, None>> signUp({required String email, required String password, required String username}) async {
    try {
      await datasource.signUp(email: email, password: password, username: username);
      return const Right(None());
    } on ServerValidationException catch(e){
      return Left(ValidationFailure(message: e.message));
    } on EmailAlreadyExistsException {
      return Left(EmailAlreadyRegisteredFailure());
    } on UsernameAlreadyExistsException {
      return Left(UsernameAlreadyRegisteredFailure());
    } catch(e){
      return Left(ServerFailure());
    }
  }

}