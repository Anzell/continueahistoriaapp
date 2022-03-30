// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoomsController on _RoomsControllerBase, Store {
  final _$failureAtom = Atom(name: '_RoomsControllerBase.failure');

  @override
  Option<String> get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(Option<String> value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  final _$listResumedRoomsAtom =
      Atom(name: '_RoomsControllerBase.listResumedRooms');

  @override
  List<ResumedGameRoom> get listResumedRooms {
    _$listResumedRoomsAtom.reportRead();
    return super.listResumedRooms;
  }

  @override
  set listResumedRooms(List<ResumedGameRoom> value) {
    _$listResumedRoomsAtom.reportWrite(value, super.listResumedRooms, () {
      super.listResumedRooms = value;
    });
  }

  final _$getRoomsByPlayerIdAsyncAction =
      AsyncAction('_RoomsControllerBase.getRoomsByPlayerId');

  @override
  Future<void> getRoomsByPlayerId({String? userId}) {
    return _$getRoomsByPlayerIdAsyncAction
        .run(() => super.getRoomsByPlayerId(userId: userId));
  }

  final _$_RoomsControllerBaseActionController =
      ActionController(name: '_RoomsControllerBase');

  @override
  void _setFailure(Failure failure) {
    final _$actionInfo = _$_RoomsControllerBaseActionController.startAction(
        name: '_RoomsControllerBase._setFailure');
    try {
      return super._setFailure(failure);
    } finally {
      _$_RoomsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
failure: ${failure},
listResumedRooms: ${listResumedRooms}
    ''';
  }
}
