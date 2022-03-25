// Mocks generated by Mockito 5.1.0 from annotations
// in continueahistoriaapp/test/domain/usecases/auth/sign_in_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:continueahistoriaapp/core/failures/failures.dart' as _i5;
import 'package:continueahistoriaapp/domain/entities/user_entity.dart' as _i6;
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> signUp(
          {String? email, String? password, String? username}) =>
      (super.noSuchMethod(
          Invocation.method(#signUp, [],
              {#email: email, #password: password, #username: username}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.UserEntity>> signIn(
          {String? email, String? password}) =>
      (super.noSuchMethod(
          Invocation.method(#signIn, [], {#email: email, #password: password}),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.UserEntity>>.value(
              _FakeEither_0<_i5.Failure, _i6.UserEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.UserEntity>>);
}
