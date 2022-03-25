import 'dart:convert';

import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:continueahistoriaapp/core/constants/server_constants.dart';

abstract class AuthRemoteDatasource {
  Future<void> signUp({required String email, required String password, required String username});
  Future<void> signIn({required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client httpClient;

  AuthRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<void> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String password, required String username}) async {
    final response = await httpClient.post(Uri.parse(ServerConstants.url + ServerConstants.signUpPath), body: {
      "email": email,
      "username": username,
      "password": password
    });
    if(json.decode(response.body)["code"] == ServerCodes.validationError){
      throw ServerValidationException(message: json.decode(response.body)["message"]);
    }
    if(json.decode(response.body)["code"] == ServerCodes.usernameAlreadyRegistered){
      throw UsernameAlreadyExistsException();
    }
    if(json.decode(response.body)["code"] == ServerCodes.emailAlreadyRegistered){
      throw EmailAlreadyExistsException();
    }
  }
  
}