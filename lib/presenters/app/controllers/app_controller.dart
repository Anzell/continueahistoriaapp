import 'package:continueahistoriaapp/domain/entities/user_entity.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  UserEntity? user;

  @action
  void setUser(UserEntity user) => this.user = user;
}