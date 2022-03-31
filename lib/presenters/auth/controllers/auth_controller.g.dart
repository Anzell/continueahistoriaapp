// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$failureAtom = Atom(name: '_AuthControllerBase.failure');

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

  final _$signInAsyncAction = AsyncAction('_AuthControllerBase.signIn');

  @override
  Future<UserEntity?> signIn({String? email, String? password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(email: email, password: password));
  }

  final _$signUpAsyncAction = AsyncAction('_AuthControllerBase.signUp');

  @override
  Future<void> signUp({String? email, String? password, String? username}) {
    return _$signUpAsyncAction.run(() =>
        super.signUp(email: email, password: password, username: username));
  }

  final _$tryAutoLoginAsyncAction =
      AsyncAction('_AuthControllerBase.tryAutoLogin');

  @override
  Future<UserEntity?> tryAutoLogin() {
    return _$tryAutoLoginAsyncAction.run(() => super.tryAutoLogin());
  }

  final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase');

  @override
  void _setFailure(Failure failure) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase._setFailure');
    try {
      return super._setFailure(failure);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
failure: ${failure}
    ''';
  }
}
