import 'package:continueahistoriaapp/core/usecases/future_usecases.dart';
import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:continueahistoriaapp/domain/usecases/server/listen_server_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final ListenServerFailuresUsecase listenServerFailuresUsecase;

  _AppControllerBase({required this.listenServerFailuresUsecase});

  @observable
  UserEntity? user;

  @action
  void setUser(UserEntity user) => this.user = user;

  @observable
  Option<String> failure = const None();

  @action
  void listenFailures() {
    listenServerFailuresUsecase(NoParams()).listen((event) {
      failure = None();
      event.fold((_) => _, (failure) {
        this.failure = optionOf(failure.message);
      });
    });
  }
}
