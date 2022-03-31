import 'package:continueahistoriaapp/core/constants/error_messages.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/auto_login.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_in.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_up.dart';
import 'package:continueahistoriaapp/presenters/auth/controllers/auth_controller.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_in_converter.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_up_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_controller_test.mocks.dart';

@GenerateMocks([SignUpUseCase, SignInUseCase, AutoLoginUsecase])
void main() {
  late SignUpConverter signUpConverter;
  late SignInConverter signInConverter;
  late MockSignInUseCase mockSignInUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockAutoLoginUsecase mockAutoLoginUsecase;
  late AuthController authController;

  setUp(() {
    signInConverter = SignInConverter();
    signUpConverter = SignUpConverter();
    mockSignUpUseCase = MockSignUpUseCase();
    mockSignInUseCase = MockSignInUseCase();
    mockAutoLoginUsecase = MockAutoLoginUsecase();
    authController = AuthController(
        autoLoginUsecase: mockAutoLoginUsecase,
        signUpUseCase: mockSignUpUseCase,
        signInConverter: signInConverter,
        signInUseCase: mockSignInUseCase,
        signUpConverter: signUpConverter,);
  });

  group("sign in", () {
    test("should sign in and no set a failure", () async {
      const email = "email@valid.com";
      const password = "123456";
      final userExpected = UserEntity(id: "validId", email: "email@valid.com", username: "username");
      when(mockSignInUseCase(any)).thenAnswer((_) async => Right(userExpected));
      final result = await authController.signIn(email: email, password: password);
      expect(result, equals(userExpected));
      expect(authController.failure, equals(None()));
    });

    test("should set a failure if call to converter fails", () async {
      const email = "invalidEmail.com";
      const password = "123456";
      final userNotExpected = UserEntity(id: "validId", email: "email@valid.com");
      when(mockSignInUseCase(any)).thenAnswer((_) async => Right(userNotExpected));
      final result = await authController.signIn(email: email, password: password);
      expect(result, equals(null));
      expect(authController.failure, equals(optionOf(SignInConverterErrorMessages.invalidEmailFormat)));
    });

    test("should set a failure if call to usecase fails", () async {
      const email = "email@valid.com";
      const password = "123456";
      when(mockSignInUseCase(any)).thenAnswer((_) async => Left(ServerFailure()));
      final result = await authController.signIn(email: email, password: password);
      expect(result, equals(null));
      expect(authController.failure, equals(optionOf(ErrorMessages.serverFailure)));
    });
  });

  group("sign up", () {
    test("should sign up", () async {
      const email = "email@valid.com";
      const password = "123456";
      const username = "anzell";
      when(mockSignUpUseCase(any)).thenAnswer((_) async => Right(None()));
      await authController.signUp(email: email, password: password, username: username);
      expect(authController.failure, equals(None()));
    });

    test("should set a failure if call to converter fails", () async {
      const email = "invalidEmail.com";
      const password = "123456";
      const username = "anzell";
      when(mockSignUpUseCase(any)).thenAnswer((_) async => Right(None()));
      await authController.signUp(email: email, password: password, username: username);
      expect(authController.failure, equals(optionOf(SignUpConverterErrorMessages.invalidEmailFormat)));
    });

    test("shoud set a failure if call to usecase fails", () async {
      const email = "email@valid.com";
      const password = "123456";
      const username = "anzell";
      when(mockSignUpUseCase(any)).thenAnswer((_) async => Left(ServerFailure()));
      await authController.signUp(email: email, password: password, username: username);
      expect(authController.failure, equals(optionOf(ErrorMessages.serverFailure)));
    });
  });

  group("try auto login", () {
    test("should return a user if call to usecase is success", () async {
      final userExpected = UserEntity(id: "validId", email: "email@valid.com", username: "username");
      when(mockAutoLoginUsecase(any)).thenAnswer((_) async => Right(userExpected));
      final result = await authController.tryAutoLogin();
      expect(result, equals(userExpected));
    });

    test("should set a failure if call to usecase is fail", () async {
      when(mockAutoLoginUsecase(any)).thenAnswer((_) async => Left(ServerFailure()));
      await authController.tryAutoLogin();
      expect(authController.failure.isSome(), equals(true));
    });
  });
}
