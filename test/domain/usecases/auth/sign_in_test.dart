import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInUseCase signInUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(repository: mockAuthRepository);
  });

  group("usecase", () {
    final testParams = SignInUseCaseParams(email: "email@email.com", password: "123456");

    test("should return right if call to repository is success", () async {
      final expected = UserEntity(id: "testId", username: "testUsername", email: "testEmail");
      when(mockAuthRepository.signIn(password: anyNamed('password'), email: anyNamed("email")))
          .thenAnswer((_) async => Right(expected));
      final result = await signInUseCase(testParams);
      expect(result, equals(Right(expected)));
    });

    test("should return left if call to repository is fail", () async {
      when(mockAuthRepository.signIn(password: anyNamed('password'), email: anyNamed("email")))
          .thenAnswer((_) async => Left(ServerFailure()));
      final result = await signInUseCase(testParams);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("params", () {
    test("should equatable working", () {
      const obj1 = SignInUseCaseParams(email: "email@email.com", password: "123456");
      const obj2 = SignInUseCaseParams(email: "email@email.com", password: "123456");
      expect(obj1, equals(obj2));
    });
  });
}
