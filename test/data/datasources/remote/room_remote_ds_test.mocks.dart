// Mocks generated by Mockito 5.1.0 from annotations
// in continueahistoriaapp/test/data/datasources/remote/room_remote_ds_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i7;
import 'dart:typed_data' as _i8;

import 'package:continueahistoriaapp/core/external/socket_service.dart' as _i12;
import 'package:hive/hive.dart' as _i4;
import 'package:hive/src/box/default_compaction_strategy.dart' as _i11;
import 'package:hive/src/box/default_key_comparator.dart' as _i10;
import 'package:http/src/base_request.dart' as _i9;
import 'package:http/src/client.dart' as _i5;
import 'package:http/src/response.dart' as _i2;
import 'package:http/src/streamed_response.dart' as _i3;
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

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

class _FakeStreamedResponse_1 extends _i1.Fake implements _i3.StreamedResponse {
}

class _FakeBox_2<E> extends _i1.Fake implements _i4.Box<E> {}

class _FakeLazyBox_3<E> extends _i1.Fake implements _i4.LazyBox<E> {}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i5.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i6.Future<_i2.Response>);
  @override
  _i6.Future<_i2.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i6.Future<_i2.Response>);
  @override
  _i6.Future<_i2.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i6.Future<_i2.Response>);
  @override
  _i6.Future<_i2.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i6.Future<_i2.Response>);
  @override
  _i6.Future<_i2.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i6.Future<_i2.Response>);
  @override
  _i6.Future<_i2.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i6.Future<_i2.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i8.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i8.Uint8List>.value(_i8.Uint8List(0)))
          as _i6.Future<_i8.Uint8List>);
  @override
  _i6.Future<_i3.StreamedResponse> send(_i9.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_1()))
          as _i6.Future<_i3.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}

/// A class which mocks [HiveInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveInterface extends _i1.Mock implements _i4.HiveInterface {
  MockHiveInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void init(String? path) =>
      super.noSuchMethod(Invocation.method(#init, [path]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<_i4.Box<E>> openBox<E>(String? name,
          {_i4.HiveCipher? encryptionCipher,
          _i4.KeyComparator? keyComparator = _i10.defaultKeyComparator,
          _i4.CompactionStrategy? compactionStrategy =
              _i11.defaultCompactionStrategy,
          bool? crashRecovery = true,
          String? path,
          _i8.Uint8List? bytes,
          List<int>? encryptionKey}) =>
      (super.noSuchMethod(
              Invocation.method(#openBox, [
                name
              ], {
                #encryptionCipher: encryptionCipher,
                #keyComparator: keyComparator,
                #compactionStrategy: compactionStrategy,
                #crashRecovery: crashRecovery,
                #path: path,
                #bytes: bytes,
                #encryptionKey: encryptionKey
              }),
              returnValue: Future<_i4.Box<E>>.value(_FakeBox_2<E>()))
          as _i6.Future<_i4.Box<E>>);
  @override
  _i6.Future<_i4.LazyBox<E>> openLazyBox<E>(String? name,
          {_i4.HiveCipher? encryptionCipher,
          _i4.KeyComparator? keyComparator = _i10.defaultKeyComparator,
          _i4.CompactionStrategy? compactionStrategy =
              _i11.defaultCompactionStrategy,
          bool? crashRecovery = true,
          String? path,
          List<int>? encryptionKey}) =>
      (super.noSuchMethod(
              Invocation.method(#openLazyBox, [
                name
              ], {
                #encryptionCipher: encryptionCipher,
                #keyComparator: keyComparator,
                #compactionStrategy: compactionStrategy,
                #crashRecovery: crashRecovery,
                #path: path,
                #encryptionKey: encryptionKey
              }),
              returnValue: Future<_i4.LazyBox<E>>.value(_FakeLazyBox_3<E>()))
          as _i6.Future<_i4.LazyBox<E>>);
  @override
  _i4.Box<E> box<E>(String? name) =>
      (super.noSuchMethod(Invocation.method(#box, [name]),
          returnValue: _FakeBox_2<E>()) as _i4.Box<E>);
  @override
  _i4.LazyBox<E> lazyBox<E>(String? name) =>
      (super.noSuchMethod(Invocation.method(#lazyBox, [name]),
          returnValue: _FakeLazyBox_3<E>()) as _i4.LazyBox<E>);
  @override
  bool isBoxOpen(String? name) =>
      (super.noSuchMethod(Invocation.method(#isBoxOpen, [name]),
          returnValue: false) as bool);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteBoxFromDisk(String? name, {String? path}) =>
      (super.noSuchMethod(
          Invocation.method(#deleteBoxFromDisk, [name], {#path: path}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  List<int> generateSecureKey() =>
      (super.noSuchMethod(Invocation.method(#generateSecureKey, []),
          returnValue: <int>[]) as List<int>);
  @override
  _i6.Future<bool> boxExists(String? name, {String? path}) =>
      (super.noSuchMethod(Invocation.method(#boxExists, [name], {#path: path}),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  void registerAdapter<T>(_i4.TypeAdapter<T>? adapter,
          {bool? internal = false, bool? override = false}) =>
      super.noSuchMethod(
          Invocation.method(#registerAdapter, [adapter],
              {#internal: internal, #override: override}),
          returnValueForMissingStub: null);
  @override
  bool isAdapterRegistered(int? typeId) =>
      (super.noSuchMethod(Invocation.method(#isAdapterRegistered, [typeId]),
          returnValue: false) as bool);
  @override
  void ignoreTypeId<T>(int? typeId) =>
      super.noSuchMethod(Invocation.method(#ignoreTypeId, [typeId]),
          returnValueForMissingStub: null);
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i4.Box<E> {
  MockBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Iterable<E> get values =>
      (super.noSuchMethod(Invocation.getter(#values), returnValue: <E>[])
          as Iterable<E>);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  bool get isOpen =>
      (super.noSuchMethod(Invocation.getter(#isOpen), returnValue: false)
          as bool);
  @override
  bool get lazy =>
      (super.noSuchMethod(Invocation.getter(#lazy), returnValue: false)
          as bool);
  @override
  Iterable<dynamic> get keys =>
      (super.noSuchMethod(Invocation.getter(#keys), returnValue: <dynamic>[])
          as Iterable<dynamic>);
  @override
  int get length =>
      (super.noSuchMethod(Invocation.getter(#length), returnValue: 0) as int);
  @override
  bool get isEmpty =>
      (super.noSuchMethod(Invocation.getter(#isEmpty), returnValue: false)
          as bool);
  @override
  bool get isNotEmpty =>
      (super.noSuchMethod(Invocation.getter(#isNotEmpty), returnValue: false)
          as bool);
  @override
  Iterable<E> valuesBetween({dynamic startKey, dynamic endKey}) =>
      (super.noSuchMethod(
          Invocation.method(
              #valuesBetween, [], {#startKey: startKey, #endKey: endKey}),
          returnValue: <E>[]) as Iterable<E>);
  @override
  E? getAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#getAt, [index])) as E?);
  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(Invocation.method(#toMap, []),
      returnValue: <dynamic, E>{}) as Map<dynamic, E>);
  @override
  dynamic keyAt(int? index) =>
      super.noSuchMethod(Invocation.method(#keyAt, [index]));
  @override
  _i6.Stream<_i4.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
      Invocation.method(#watch, [], {#key: key}),
      returnValue: Stream<_i4.BoxEvent>.empty()) as _i6.Stream<_i4.BoxEvent>);
  @override
  bool containsKey(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#containsKey, [key]),
          returnValue: false) as bool);
  @override
  _i6.Future<void> put(dynamic key, E? value) =>
      (super.noSuchMethod(Invocation.method(#put, [key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> putAt(int? index, E? value) =>
      (super.noSuchMethod(Invocation.method(#putAt, [index, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> putAll(Map<dynamic, E>? entries) =>
      (super.noSuchMethod(Invocation.method(#putAll, [entries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<int> add(E? value) =>
      (super.noSuchMethod(Invocation.method(#add, [value]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Iterable<int>> addAll(Iterable<E>? values) =>
      (super.noSuchMethod(Invocation.method(#addAll, [values]),
              returnValue: Future<Iterable<int>>.value(<int>[]))
          as _i6.Future<Iterable<int>>);
  @override
  _i6.Future<void> delete(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#deleteAt, [index]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteAll(Iterable<dynamic>? keys) =>
      (super.noSuchMethod(Invocation.method(#deleteAll, [keys]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> compact() =>
      (super.noSuchMethod(Invocation.method(#compact, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<int> clear() => (super.noSuchMethod(Invocation.method(#clear, []),
      returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> flush() => (super.noSuchMethod(Invocation.method(#flush, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}

/// A class which mocks [SocketService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSocketService extends _i1.Mock implements _i12.SocketService {
  MockSocketService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> initSocket() =>
      (super.noSuchMethod(Invocation.method(#initSocket, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void emitEvent({dynamic data}) =>
      super.noSuchMethod(Invocation.method(#emitEvent, [], {#data: data}),
          returnValueForMissingStub: null);
  @override
  _i6.Stream<dynamic> eventListener({String? event}) => (super.noSuchMethod(
      Invocation.method(#eventListener, [], {#event: event}),
      returnValue: Stream<dynamic>.empty()) as _i6.Stream<dynamic>);
}
