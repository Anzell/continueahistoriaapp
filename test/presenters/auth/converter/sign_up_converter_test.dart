import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/presenters/auth/converters/sign_up_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late SignUpConverter signUpConverter;

  setUp((){
    signUpConverter = SignUpConverter();
  });

  test("should return Right with valid object if call to converter is success", (){
    final result = signUpConverter(const SignUpConverterParams(email: "email@valid.com", password: "123456", username: "anzell"));
    expect(result, equals(const Right(SignUpConverted(
      email: "email@valid.com",
      password: "123456",
      username: "anzell",
    ))));
  });

  test("should return left with message error if email is invalid", () {
    const email = "invalidEmail.com";
    const password = "123456";
    const username = "anzell";
    final result = signUpConverter(const SignUpConverterParams(password: password, email: email, username: username));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.invalidEmailFormat))));
  });

  test("should return left with message if password or email are missing", () {
    Either<ValidationFailure, SignUpConverted> result;
    result = signUpConverter(const SignUpConverterParams(password: null, email: "email@valid.com", username: "anzell"));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.missingPassword))));
    result = signUpConverter(const SignUpConverterParams(password: "", email: "email@valid.com", username: "anzell"));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.missingPassword))));
    result = signUpConverter(const SignUpConverterParams(password: "123456", email: null, username: "anzell"));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.missingEmail))));
    result = signUpConverter(const SignUpConverterParams(password: "123456", email: "", username: "anzell"));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.missingEmail))));
    result = signUpConverter(const SignUpConverterParams(password: "123456", email: "email@valid.com", username: null));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.missingEmail))));
    result = signUpConverter(const SignUpConverterParams(password: "123456", email: "email@valid.com", username: ""));
    expect(result, equals(Left(ValidationFailure(message: SignUpConverterErrorMessages.missingEmail))));
  });
}