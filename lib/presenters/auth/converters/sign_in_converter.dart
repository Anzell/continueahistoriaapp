import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/helpers/regex_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignInConverter implements Converter<SignInConverted, SignInConverterParams>{
  @override
  Either<ValidationFailure, SignInConverted> call(SignInConverterParams params) {
    if(params.password == null || params.password == ""){
      return Left(ValidationFailure(message: SignInConverterErrorMessages.missingPassword));
    }
    if(params.email == null || params.email == ""){
      return Left(ValidationFailure(message: SignInConverterErrorMessages.missingEmail));
    }
    if(!RegexHelper.email.hasMatch(params.email!)){
      return Left(ValidationFailure(message: SignInConverterErrorMessages.invalidEmailFormat));
    }
    return Right(SignInConverted(email: params.email!, password: params.password!));
  }

}

class SignInConverted extends Equatable {
  final String email;
  final String password;

  const SignInConverted({required this.password, required this.email});

  @override
  List<Object> get props => [password, email];
}

class SignInConverterParams extends Equatable{
  final String? email;
  final String? password;

  const SignInConverterParams({this.password, this.email});

  @override
  List<Object?> get props => [email, password];
}

class SignInConverterErrorMessages {
  static const String missingPassword = "Senha é necessária";
  static const String missingEmail = "Informe um email";
  static const String invalidEmailFormat = "Email em formato inválido";
}