// Mocks generated by Mockito 5.1.0 from annotations
// in continueahistoriaapp/test/data/repositories/room_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:continueahistoriaapp/data/datasources/remote/room_remote_ds.dart'
    as _i2;
import 'package:continueahistoriaapp/domain/entities/game_room.dart' as _i5;
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart'
    as _i4;
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

/// A class which mocks [RoomRemoteDs].
///
/// See the documentation for Mockito's code generation for more information.
class MockRoomRemoteDs extends _i1.Mock implements _i2.RoomRemoteDs {
  MockRoomRemoteDs() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.ResumedGameRoom>> getPlayerRooms({String? userId}) =>
      (super.noSuchMethod(
              Invocation.method(#getPlayerRooms, [], {#userId: userId}),
              returnValue: Future<List<_i4.ResumedGameRoom>>.value(
                  <_i4.ResumedGameRoom>[]))
          as _i3.Future<List<_i4.ResumedGameRoom>>);
  @override
  _i3.Stream<_i5.GameRoom> listenRoomUpdate({String? roomId}) =>
      (super.noSuchMethod(
              Invocation.method(#listenRoomUpdate, [], {#roomId: roomId}),
              returnValue: Stream<_i5.GameRoom>.empty())
          as _i3.Stream<_i5.GameRoom>);
  @override
  _i3.Future<void> sendPhrase(
          {String? roomId, String? userId, String? phrase}) =>
      (super.noSuchMethod(
          Invocation.method(#sendPhrase, [],
              {#roomId: roomId, #userId: userId, #phrase: phrase}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> createRoom({_i5.GameRoom? roomData, String? userId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #createRoom, [], {#roomData: roomData, #userId: userId}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> lockRoom({String? roomId, String? userId}) =>
      (super.noSuchMethod(
          Invocation.method(#lockRoom, [], {#roomId: roomId, #userId: userId}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> addPlayerInRoom({String? username, String? roomId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #addPlayerInRoom, [], {#username: username, #roomId: roomId}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}
