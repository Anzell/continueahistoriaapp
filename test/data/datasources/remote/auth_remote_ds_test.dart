import 'dart:convert';

import 'package:continueahistoriaapp/core/constants/server_constants.dart';
import 'package:continueahistoriaapp/core/failures/exceptions.dart';
import 'package:continueahistoriaapp/data/datasources/remote/auth_remote_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import './auth_remote_ds_test.mocks.dart';

@GenerateMocks([http.Client])
void main () {
  late MockClient mockClient;
  late AuthRemoteDatasourceImpl authRemoteDatasourceImpl;

  setUp((){
    mockClient = MockClient();
    authRemoteDatasourceImpl = AuthRemoteDatasourceImpl(httpClient: mockClient);
  });
  
  group("signUp", () {
    const username = "testUsername";
    const email = "email@email.com";
    const password = "123456";
    
    test("should call the Api and test with a valid response", () async {
      when(mockClient.post(any, body: anyNamed("body"))).thenAnswer((_) async => http.Response('{}', 201));
      await authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      verify(mockClient.post(any, body: anyNamed("body"))).called(1);
    });
    
    test("should throw a ServerValidationException if response is validation_failure", () async {
      when(mockClient.post(any, body: anyNamed("body"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "teste erro validacao",
        "code": ServerCodes.validationError,
        "result": {}
      }), 400));
      final response = authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      expect(response, throwsA(isA<ServerValidationException>()));
      verify(mockClient.post(any, body: anyNamed("body"))).called(1);
    });

    test("should throw a UsernameAlreadyRegistered if response is fail", () async {
      when(mockClient.post(any, body: anyNamed("body"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "teste erro validacao",
        "code": ServerCodes.usernameAlreadyRegistered,
        "result": {}
      }), 400));
      final response = authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      expect(response, throwsA(isA<UsernameAlreadyExistsException>()));
      verify(mockClient.post(any, body: anyNamed("body"))).called(1);
    });

    test("should throw a EmailAlreadyRegistered if response is fail", () async {
      when(mockClient.post(any, body: anyNamed("body"))).thenAnswer((_) async => http.Response(json.encode({
        "codeStatus": 400,
        "message": "teste erro validacao",
        "code": ServerCodes.emailAlreadyRegistered,
        "result": {}
      }), 400));
      final response = authRemoteDatasourceImpl.signUp(email: email, password: password, username: username);
      expect(response, throwsA(isA<EmailAlreadyExistsException>()));
      verify(mockClient.post(any, body: anyNamed("body"))).called(1);
    });
  });
}