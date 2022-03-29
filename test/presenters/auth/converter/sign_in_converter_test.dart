import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_in_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SignInConverter signInConverter;

  setUp(() {
    signInConverter = SignInConverter();
  });

  test("should return valid object if call to converter is success", () {
    final email = "email@valid.com";
    final password = "123456";
    final result = signInConverter(SignInConverterParams(password: password, email: email));
    expect(result, equals(Right(SignInConverted(password: password, email: email))));
  });

  test("should return left with message error if email is invalid", () {
    final email = "invalidEmail.com";
    final password = "123456";
    final result = signInConverter(SignInConverterParams(password: password, email: email));
    expect(result, equals(Left(ValidationFailure(message: SignInConverterErrorMessages.invalidEmailFormat))));
  });

  test("should return left with message if password or email are missing", () {
    Either<ValidationFailure, SignInConverted> result;
    result = signInConverter(SignInConverterParams(password: null, email: "email@valid.com"));
    expect(result, equals(Left(ValidationFailure(message: SignInConverterErrorMessages.missingPassword))));
    result = signInConverter(SignInConverterParams(password: "", email: "email@valid.com"));
    expect(result, equals(Left(ValidationFailure(message: SignInConverterErrorMessages.missingPassword))));
    result = signInConverter(SignInConverterParams(password: "123456", email: null));
    expect(result, equals(Left(ValidationFailure(message: SignInConverterErrorMessages.missingEmail))));
    result = signInConverter(SignInConverterParams(password: "123456", email: ""));
    expect(result, equals(Left(ValidationFailure(message: SignInConverterErrorMessages.missingEmail))));
  });
}
