// Mocks generated by Mockito 5.1.0 from annotations
// in continueahistoriaapp/test/domain/usecases/room/add_player_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:continueahistoriaapp/core/failures/failures.dart' as _i5;
import 'package:continueahistoriaapp/domain/entities/game_room.dart' as _i7;
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart'
    as _i6;
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart'
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

/// A class which mocks [RoomRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRoomRepository extends _i1.Mock implements _i3.RoomRepository {
  MockRoomRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ResumedGameRoom>>> getPlayerRooms(
          {String? userId}) =>
      (super.noSuchMethod(
              Invocation.method(#getPlayerRooms, [], {#userId: userId}),
              returnValue: Future<
                      _i2.Either<_i5.Failure, List<_i6.ResumedGameRoom>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i6.ResumedGameRoom>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ResumedGameRoom>>>);
  @override
  _i4.Stream<_i2.Either<_i5.Failure, _i7.GameRoom>> listenRoom(
          {String? roomId}) =>
      (super.noSuchMethod(Invocation.method(#listenRoom, [], {#roomId: roomId}),
              returnValue:
                  Stream<_i2.Either<_i5.Failure, _i7.GameRoom>>.empty())
          as _i4.Stream<_i2.Either<_i5.Failure, _i7.GameRoom>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> sendPhrase(
          {String? roomId, String? userId, String? phrase}) =>
      (super.noSuchMethod(
          Invocation.method(#sendPhrase, [],
              {#roomId: roomId, #userId: userId, #phrase: phrase}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> createRoom(
          {_i7.GameRoom? roomData, String? userId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #createRoom, [], {#roomData: roomData, #userId: userId}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> addPlayerInRoom(
          {String? roomId, String? userId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #addPlayerInRoom, [], {#roomId: roomId, #userId: userId}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
}
