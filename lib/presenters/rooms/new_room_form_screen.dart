import 'package:continueahistoriaapp/core/themes/app_colors.dart';
import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/widgets/icon_button.dart';
import 'package:continueahistoriaapp/presenters/widgets/input_form.dart';
import 'package:flutter/material.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:mobx/mobx.dart';

class NewRoomFormScreen extends StatelessWidget {
  final Function() onCreateRoom;

  NewRoomFormScreen({Key? key, required this.onCreateRoom}) : super(key: key);
  final _appController = getIt<AppController>();
  final _roomNameController = TextEditingController(text: "Era uma vez");
  final _roomController = getIt<RoomsController>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _reactionFailureSetup(context);
    return Scaffold(
      appBar: AppBar(title: Text("Nova sala")),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(8),
                child: CustomInputForm(
                  controller: _roomNameController,
                  placeholder: "Nome da história",
                ),
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) => _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomIconButton(
                      icon: Icon(Icons.check_circle_outline_sharp),
                      backgroundColor: AppColors.darkGreen,
                      onTap: () async {
                        setState(() => _isLoading = true);
                        await _createRoom();
                        if (_roomController.failure.isNone()) {
                          onCreateRoom();
                          Navigator.of(context).pop();
                        }
                        setState(() => _isLoading = false);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _reactionFailureSetup(BuildContext context) {
    reaction(
      (_) => _roomController.failure,
      (_) => _roomController.failure.map(
        (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }

  Future<void> _createRoom() async {
    await _roomController.createRoom(name: _roomNameController.text, userId: _appController.user?.id);
  }
}
