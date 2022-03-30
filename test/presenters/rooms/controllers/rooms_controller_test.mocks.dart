// Mocks generated by Mockito 5.1.0 from annotations
// in continueahistoriaapp/test/presenters/rooms/controllers/rooms_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:continueahistoriaapp/core/failures/failures.dart' as _i6;
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart'
    as _i7;
import 'package:continueahistoriaapp/domain/repositories/room_repository.dart'
    as _i2;
import 'package:continueahistoriaapp/domain/usecases/room/get_player_rooms.dart'
    as _i4;
import 'package:dartz/dartz.dart' as _i3;
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

class _FakeRoomRepository_0 extends _i1.Fake implements _i2.RoomRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetPlayerRoomsUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPlayerRoomsUsecase extends _i1.Mock
    implements _i4.GetPlayerRoomsUsecase {
  MockGetPlayerRoomsUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RoomRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRoomRepository_0()) as _i2.RoomRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.ResumedGameRoom>>> call(
          _i4.GetPlayerRoomsUsecaseParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i3.Either<_i6.Failure, List<_i7.ResumedGameRoom>>>.value(
                  _FakeEither_1<_i6.Failure, List<_i7.ResumedGameRoom>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.ResumedGameRoom>>>);
}