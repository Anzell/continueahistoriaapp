
import 'package:continueahistoriaapp/core/converters/converter.dart';
import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/helpers/regex_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpConverter implements Converter<SignUpConverted, SignUpConverterParams>{
  @override
  Either<ValidationFailure, SignUpConverted> call(SignUpConverterParams params) {
    if(params.password == null || params.password == ""){
      return Left(ValidationFailure(message: SignUpConverterErrorMessages.missingPassword));
    }
    if(params.email == null || params.email == ""){
      return Left(ValidationFailure(message: SignUpConverterErrorMessages.missingEmail));
    }
    if(params.username == null || params.username == ""){
      return Left(ValidationFailure(message: SignUpConverterErrorMessages.missingUsername));
    }
    if(!RegexHelper.email.hasMatch(params.email!)){
      return Left(ValidationFailure(message: SignUpConverterErrorMessages.invalidEmailFormat));
    }
    return Right(SignUpConverted(password: params.password!, email: params.email!, username: params.username!));
  }

}

class SignUpConverted extends Equatable{
  final String email;
  final String username;
  final String password;

  const SignUpConverted({required this.email, required this.password, required this.username});

  @override
  List<Object> get props => [email, username, password];
}

class SignUpConverterParams extends Equatable {
  final String? email;
  final String? username;
  final String? password;

  const SignUpConverterParams({this.email, this.password, this.username});

  @override
  List<Object?> get props => [email, username, password];
}

class SignUpConverterErrorMessages {
  static const String missingEmail = "É necessário informar um email";
  static const String missingUsername = "É necessário informar um nome de usuário";
  static const String missingPassword = "É necessário informar uma senha";
  static const String invalidEmailFormat = "É necessário informar um email em formato válido";
}