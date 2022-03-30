import 'dart:convert';

import 'package:continueahistoriaapp/core/constants/hive_constants.dart';
import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/datasources/remote/auth_remote_ds.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import './auth_remote_ds_test.mocks.dart';

@GenerateMocks([http.Client, HiveInterface, Box])
void main () {
  late MockClient mockClient;
  late MockHiveInterface mockHiveInterface;
  late AuthRemoteDatasourceImpl authRemoteDatasourceImpl;

  setUp((){
    mockClient = MockClient();
    mockHiveInterface = MockHiveInterface();
    authRemoteDatasourceImpl = AuthRemoteDatasourceImpl(httpClient: mockClient, hive: mockHiveInterface);
  });
  
  group("signUp", () {
    const username = "testUsername";
    const email = "email@email.com";
    const password = "123456";
    
    test("should call the Api and test with a valid response", () async {
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response('{}', 201));
      await authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      verify(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).called(1);
    });
    
    test("should throw a ServerValidationException if response is validation_failure", () async {
      when(mockClient.post(any, body: anyNamed("body"), headers: {
        "Content-Type": "application/json"
      })).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "teste erro validacao",
        "code": ServerCodes.validationError,
        "result": {}
      }), 400));
      final response = authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      expect(response, throwsA(isA<ServerValidationException>()));
      verify(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).called(1);
    });

    test("should throw a UsernameAlreadyRegistered if response is fail", () async {
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "teste erro validacao",
        "code": ServerCodes.usernameAlreadyRegistered,
        "result": {}
      }), 400));
      final response = authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      expect(response, throwsA(isA<UsernameAlreadyExistsException>()));
      verify(mockClient.post(any, body: anyNamed("body"),headers: anyNamed("headers"))).called(1);
    });

    test("should throw a EmailAlreadyRegistered if response is fail", () async {
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "teste erro validacao",
        "code": ServerCodes.emailAlreadyRegistered,
        "result": {}
      }), 400));
      final response = authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      expect(response, throwsA(isA<EmailAlreadyExistsException>()));
      verify(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).called(1);
    });
  });

  group("signIn", () {
    const email = "email@email.com";
    const password = "123456";

    test("should make a validLogin returning a valid User", () async {
      final expected = UserEntity(id: "validId", email: email, username: "username");
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 200,
        "message": "sucesso na operação",
        "code": ServerCodes.success,
        "result": {
          "id": "validId",
          "token": "validToken"
        }
      }), 200));
      when(mockClient.get(any, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer validToken"
      })).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 200,
        "message": "sucesso na operação",
        "code": ServerCodes.success,
        "result": {
          "id": "validId",
          "email": "email@email.com",
          "username": "username"
        }
      }), 200));
      final mockHiveBox = MockBox();
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.put(any, any)).thenAnswer((_) => Future.value());
      when(mockHiveBox.get(any)).thenReturn("validToken");
      final result = await authRemoteDatasourceImpl.signIn(email: email, password: password);
      expect(result, equals(expected));
    });

    test("should throw InvalidCredentials if call to api is fail", () async {
      when(mockClient.post(any, body: anyNamed("body"), headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "credentiais invalidas",
        "code": ServerCodes.invalidCredentials,
        "result": {}
      }), 400));
      final result = authRemoteDatasourceImpl.signIn(email: email, password: password);
      expect(result, throwsA(isA<InvalidCredentialsException>()));
    });

  });

  group("auto login", () {

  test("should return a valid user if authorization is setted", () async {
    final expected = UserEntity(id: "validId", email: "email@valid.com", username: "username");
    final mockHiveBox = MockBox();
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
    when(mockHiveBox.put(any, any)).thenAnswer((_) => Future.value());
    when(mockHiveBox.get(HiveStaticKeys.token)).thenReturn("validToken");
    when(mockHiveBox.get(HiveStaticKeys.userModel)).thenReturn({
      "id": "validId",
      "username": "username",
      "email": "email@valid.com"
    });
    final result = await authRemoteDatasourceImpl.tryAutoLogin();
    expect(result, equals(expected));
  });

  test("should return null if no one User is saved", () async {
    final mockHiveBox = MockBox();
    when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
    when(mockHiveBox.get(HiveStaticKeys.token)).thenReturn(null);
    final result = await authRemoteDatasourceImpl.tryAutoLogin();
    expect(result, equals(null));
  });
  });
}