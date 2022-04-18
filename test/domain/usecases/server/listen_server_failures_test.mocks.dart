// Mocks generated by Mockito 5.1.0 from annotations
// in continueahistoriaapp/test/domain/usecases/server/listen_server_failures_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:continueahistoriaapp/core/failures/failures.dart' as _i5;
import 'package:continueahistoriaapp/domain/repositories/server_repository.dart'
    as _i2;
import 'package:dartz/dartz.dart' as _i4;
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

/// A class which mocks [ServerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockServerRepository extends _i1.Mock implements _i2.ServerRepository {
  MockServerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<_i4.Either<_i5.Failure, _i5.ReceivedServerFailure>>
      listenServerFailures() => (super.noSuchMethod(
              Invocation.method(#listenServerFailures, []),
              returnValue: Stream<
                  _i4.Either<_i5.Failure, _i5.ReceivedServerFailure>>.empty())
          as _i3.Stream<_i4.Either<_i5.Failure, _i5.ReceivedServerFailure>>);
}
