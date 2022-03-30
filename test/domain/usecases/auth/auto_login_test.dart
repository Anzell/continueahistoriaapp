import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/auto_login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auto_login_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main(){
  late MockAuthRepository mockAuthRepository;
  late AutoLoginUsecase autoLoginUsecase;

  setUp((){
    mockAuthRepository = MockAuthRepository();
    autoLoginUsecase = AutoLoginUsecase(repository: mockAuthRepository);
  });

  test("should return right if call to repository is success", () async {
    final expected = UserEntity(id: "testId", username: "testUsername", email: "testEmail");
    when(mockAuthRepository.tryAutoLogin())
        .thenAnswer((_) async => Right(expected));
    final result = await autoLoginUsecase(NoParams());
    expect(result, equals(Right(expected)));
  });

  test("should return left if call to repository is fail", () async {
    when(mockAuthRepository.tryAutoLogin())
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await autoLoginUsecase(NoParams());
    expect(result, equals(Left(ServerFailure())));
  });
}