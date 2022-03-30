import 'dart:math';

import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/data/datasources/remote/auth_remote_ds.dart';
import 'package:continueahistoriaapp/data/repositories/auth_repository_impl.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
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

  group("signIn", () {
    const email = "email@email.com";
    const password = "123456";

    test("should return a Right with a valid UserEntity object if call to datasource is valid", () async {
      const expected = UserEntity(id: "validId", email: "email@email.com", username: "validUsername");
      when(mockAuthDatasource.signIn(email: anyNamed("email"), password: anyNamed("password"))).thenAnswer((_) async => expected);
      final response = await authRepositoryImpl.signIn(email: email, password: password);
      expect(response, equals(const Right(expected)));
    });

    test("should return a Left with a ServerFailure object if call to datasource is fail", () async {
      when(mockAuthDatasource.signIn(email: anyNamed("email"), password: anyNamed("password"))).thenThrow(ServerException());
      final response = await authRepositoryImpl.signIn(email: email, password: password);
      expect(response, equals(Left(ServerFailure())));
    });

    test("should return a Left with a InvalidCredentials object if call to datasource is fail", () async {
      when(mockAuthDatasource.signIn(email: anyNamed("email"), password: anyNamed("password"))).thenThrow(InvalidCredentialsException());
      final response = await authRepositoryImpl.signIn(email: email, password: password);
      expect(response, equals(Left(InvalidCredentialsFailure())));
    });
  });

  group("try auto login", () {
    test("should return a Right with a valid UserEntity object if call to datasource is valid", () async {
      const expected = UserEntity(id: "validId", email: "email@email.com", username: "validUsername");
      when(mockAuthDatasource.tryAutoLogin()).thenAnswer((_) async => expected);
      final response = await authRepositoryImpl.tryAutoLogin();
      expect(response, equals(const Right(expected)));
    });

    test("should return a Left with a ServerFailure object if call to datasource is fail", () async {
      when(mockAuthDatasource.tryAutoLogin()).thenThrow(ServerException());
      final response = await authRepositoryImpl.tryAutoLogin();
      expect(response, equals(Left(ServerFailure())));
    });
  });
}