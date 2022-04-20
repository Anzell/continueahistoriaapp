import 'dart:convert';

import 'package:continueahistoriaapp/core/constants/hive_constants.dart';
import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/mappers/user_mapper.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:continueahistoriaapp/core/constants/server_constants.dart';

import '../../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<void> signUp({required String email, required String password, required String username});
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity?> tryAutoLogin();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client httpClient;
  final HiveInterface hive;

  AuthRemoteDatasourceImpl({required this.httpClient, required this.hive});

  @override
  Future<UserEntity> signIn({required String email, required String password}) async {
    final responseLogin = await httpClient.post(Uri.parse(ServerConstants.url + ServerConstants.loginPath), body: json.encode({
      "email": email,
      "password": password,
    }), headers: {
      "Content-Type": "application/json"
    });

    if (json.decode(responseLogin.body)["code"] == ServerCodes.success) {
      await _saveTokenInStorage(json.decode(responseLogin.body)["result"]["token"]);
      final user = await _getUser(json.decode(responseLogin.body)["result"]["id"]);
      await _saveUserInStorage(user);
      return user;
    }
    if (json.decode(responseLogin.body)["code"] == ServerCodes.invalidCredentials) {
      throw InvalidCredentialsException();
    }
    throw ServerException();
  }

  Future<void> _saveTokenInStorage(String token) async{
    final box = await hive.openBox(HiveStaticBoxes.authorization);
    await box.put(HiveStaticKeys.token, token);
    await box.close();
  }

  Future<void> _saveUserInStorage(UserEntity user) async {
    final box = await hive.openBox(HiveStaticBoxes.loggedUser);
    await box.put(HiveStaticKeys.userModel, UserMapper.entityToModel(user).toJson());
    await box.close();
  }

  Future<UserEntity> _getUser(String id) async {
    final path = ServerConstants.url + ServerConstants.getUserByIdPath + id;
    final response = await httpClient.get(Uri.parse(path), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await _getAuthorizationToken()}",
    });
    if (json.decode(response.body)["code"] == ServerCodes.success) {
      return UserMapper.modelToEntity(UserModel.fromJson(json.decode(response.body)['result']));
    }
    throw ServerException();
  }

  Future<String?> _getAuthorizationToken() async {
    final box = await hive.openBox(HiveStaticBoxes.authorization);
    final token = box.get(HiveStaticKeys.token);
    await box.close();
    return token;
  }

  @override
  Future<void> signUp({required String email, required String password, required String username}) async {
    final response = await httpClient.post(Uri.parse(ServerConstants.url + ServerConstants.signUpPath), body: json.encode({
      "email": email,
      "username": username,
      "password": password,
    }), headers: {
      "Content-Type": "application/json"
    });
    if (json.decode(response.body)["code"] == ServerCodes.validationError) {
      throw ServerValidationException(message: json.decode(response.body)["message"]);
    }
    if (json.decode(response.body)["code"] == ServerCodes.usernameAlreadyRegistered) {
      throw UsernameAlreadyExistsException();
    }
    if (json.decode(response.body)["code"] == ServerCodes.emailAlreadyRegistered) {
      throw EmailAlreadyExistsException();
    }
  }

  @override
  Future<UserEntity?> tryAutoLogin() async {
    if(await _getAuthorizationToken() == null) return null;
    return await _getUserFromStorage();
  }

  Future<UserEntity?> _getUserFromStorage() async {
    final box = await hive.openBox(HiveStaticBoxes.loggedUser);
    final userJson = await box.get(HiveStaticKeys.userModel);
    if(userJson == null) return null;
    await box.close();
    return UserMapper.modelToEntity(UserModel.fromJson({
      "email": userJson["email"],
      "username": userJson["username"],
      "id": userJson["id"]
    }));
  }
}
