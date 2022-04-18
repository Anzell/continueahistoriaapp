import 'package:continueahistoriaapp/core/themes/app_colors.dart';
import 'package:continueahistoriaapp/domain/entities/game_room.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:continueahistoriaapp/presenters/widgets/icon_button.dart';
import 'package:continueahistoriaapp/presenters/widgets/input_form.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../di/injector.dart';

class RoomConfigScreen extends StatelessWidget {
  final GameRoom room;
  final roomsController = getIt<RoomsController>();

  RoomConfigScreen({required this.room});

  @override
  Widget build(BuildContext context) {
    _reactionFailureSetup(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuração da sala"),
        actions: [IconButton(onPressed: () async => await _showAddUserAlert(context), icon: Icon(Icons.person_add))],
      ),
    );
  }

  String _failureInController = "";
  bool loading = false;

  Future<void> _showAddUserAlert(BuildContext context) async {
    final _usernameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.grey,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInputForm(
              controller: _usernameController,
              placeholder: "Insira o username",
              prefixIcon: Icon(Icons.contacts),
            ),
            SizedBox(height: 10),
            StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  Text(_failureInController),
                  SizedBox(height: 10),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : CustomIconButton(
                          icon: Icon(Icons.check_circle_outline),
                          backgroundColor: Colors.white,
                          onTap: () async {
                            setState(() => loading = true);
                            await roomsController.addPlayerInRoom(
                              username: _usernameController.text,
                              roomId: room.id ?? "",
                            );
                            setState(() => loading = false);
                            if(roomsController.failure.isNone()){
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  void _reactionFailureSetup(BuildContext context) {
    reaction(
      (_) => roomsController.failure,
      (_) => roomsController.failure.map((message) => _failureInController = message),
    );
  }
}
