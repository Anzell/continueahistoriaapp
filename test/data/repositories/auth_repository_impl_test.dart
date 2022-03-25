import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/data/datasources/remote/auth_remote_ds.dart';
import 'package:continueahistoriaapp/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDatasource])
void main() {
  late MockAuthRemoteDatasource mockAuthDatasource;
  late AuthRepositoryImpl authRepositoryImpl;

  const String username = "username";
  const String email = "email@email.com";
  const String password = "123456";

  setUp((){
    mockAuthDatasource = MockAuthRemoteDatasource();
    authRepositoryImpl = AuthRepositoryImpl(datasource: mockAuthDatasource);
  });

  group("signUp", () {
    test("should return Right with None if call to datasource is success", () async {
      when(mockAuthDatasource.signUp(email: anyNamed("email"), password: anyNamed("password"), username: anyNamed("username"))).thenAnswer((_) async => null);
      final response = await authRepositoryImpl.signUp(email: email, password: password, username: username);
      expect(response, equals(const Right(None())));
    });

    test("should return Left with ServerError if call to datasource is fail", () async {
      when(mockAuthDatasource.signUp(email: anyNamed("email"), password: anyNamed("password"), username: anyNamed("username"))).thenThrow(ServerException());
      final response = await authRepositoryImpl.signUp(email: email, password: password, username: username);
      expect(response, equals(Left(ServerFailure())));
    });

    test("should return Left with UsernameAlreadyExistsFailure if catch to datasource is fail", () async {
      when(mockAuthDatasource.signUp(email: anyNamed("email"), password: anyNamed("password"), username: anyNamed("username"))).thenThrow(UsernameAlreadyExistsException());
      final response = await authRepositoryImpl.signUp(email: email, password: password, username: username);
      expect(response, equals(Left(UsernameAlreadyRegisteredFailure())));
    });

    test("should return Left with EmailAlreadyExistsFailure if catch to datasource is fail", () async {
      when(mockAuthDatasource.signUp(email: anyNamed("email"), password: anyNamed("password"), username: anyNamed("username"))).thenThrow(EmailAlreadyExistsException());
      final response = await authRepositoryImpl.signUp(email: email, password: password, username: username);
      expect(response, equals(Left(EmailAlreadyRegisteredFailure())));
    });
  });
}