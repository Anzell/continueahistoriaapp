import 'package:continueahistoriaapp/core/failures/failures.dart';
import 'package:continueahistoriaapp/domain/repositories/auth_repository.dart';
import 'package:continueahistoriaapp/domain/usecases/auth/sign_up.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main () {
  late MockAuthRepository mockAuthRepository;
  late SignUpUseCase usecase;

  const testParams = SignUpUseCaseParams(email: "email@email.com", password: "123456", username: "anzell");

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignUpUseCase(repository: mockAuthRepository);
  });

  group("sign up use case", ()  {
    test("should return right if call to repository is success", () async {
      when(mockAuthRepository.signUp(password: anyNamed('password'), email: anyNamed("email"), username: anyNamed("username"))).thenAnswer((_) async => const Right(None()));
      final result = await usecase(testParams);
      expect(result, equals(const Right(None())));
    });

    test("should return right if call to repository is success", () async {
      when(mockAuthRepository.signUp(password: anyNamed('password'), email: anyNamed("email"), username: anyNamed("username"))).thenAnswer((_) async => Left(ServerFailure()));
      final result = await usecase(testParams);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("sign up use case params", () {
    test("should equatable working", () {
      const obj1 = SignUpUseCaseParams(email: "test@email.com", password: "123456", username: "anzell");
      const obj2 = SignUpUseCaseParams(email: "test@email.com", password: "123456", username: "anzell");
      expect(obj1, equals(obj2));
    });
  });
}