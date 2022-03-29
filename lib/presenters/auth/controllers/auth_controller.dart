import 'dart:async';

import 'package:continueahistoriaapp/core/helpers/failure_helper.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_in.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_up.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_in_converter.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_up_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../core/failures/failures.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  late SignUpUseCase signUpUseCase;
  late SignInUseCase signInUseCase;
  late SignUpConverter signUpConverter;
  late SignInConverter signInConverter;

  _AuthControllerBase({
    required this.signInConverter,
    required this.signUpConverter,
    required this.signInUseCase,
    required this.signUpUseCase,
  });

  @observable
  Option<String> failure = const None();

  @action
  void _setFailure(Failure failure) {
    this.failure = optionOf(FailureHelper.mapFailureToMessage(failure));
  }

  @action
  Future<UserEntity?> signIn({String? email, String? password}) async {
    failure = const None();
    final completer = Completer();
    UserEntity? userTemp;
    Future(() {
      final convertResult = signInConverter(SignInConverterParams(password: password, email: email));
      convertResult.fold((failure) {
        _setFailure(failure);
        completer.complete();
      }, (convertedResult) async {
        final usecaseResult = await signInUseCase(
          SignInUseCaseParams(
            email: convertedResult.email,
            password: convertedResult.password,
          ),
        );
        usecaseResult.fold((failure) {
          _setFailure(failure);
          completer.complete();
        }, (user) {
          userTemp = user;
          completer.complete();
        });
      });
    });
    await completer.future;
    return userTemp;
  }

  Future<void> signUp({String? email, String? password, String? username}) async {
    failure = None();
    final completer = Completer();
    Future(() {
      final converterResult =
          signUpConverter(SignUpConverterParams(password: password, email: email, username: username));
      converterResult.fold((failure) {
        _setFailure(failure);
        completer.complete();
      }, (convertedResult) async {
        final usecaseResult = await signUpUseCase(SignUpUseCaseParams(
          email: convertedResult.email,
          password: convertedResult.password,
          username: convertedResult.username,
        ));
        usecaseResult.fold((failure) {
          _setFailure(failure);
          completer.complete();
        }, (_) => completer.complete());
      });
    });
    await completer.future;
  }
}
