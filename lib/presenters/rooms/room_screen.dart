import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:continueahistoriaapp/presenters/widgets/input_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../di/injector.dart';

class RoomScreen extends StatelessWidget {
  final RoomsController roomsController;
  final String roomId;
  final _scrollController = ScrollController(initialScrollOffset: 40);
  final _phraseController = TextEditingController();

  RoomScreen({Key? key, required this.roomsController, required this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initializeListener();
    _reactionFailureSetup(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sala"),
      ),
      body: Stack(
        children: [
          Scrollbar(
            controller: _scrollController,
            showTrackOnHover: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Observer(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black, height: 2),
                              children: roomsController.listeningRoom?.history
                                      ?.map((e) => TextSpan(text: "${e.phrase!} "))
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: CustomInputForm(
                placeholder: "continue a história",
                controller: _phraseController,
                suffixIconButton: IconButton(
                  icon: Icon(Icons.send, color: Colors.black),
                  onPressed: () async => _sendPhrase(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _initializeListener() {
    reaction((_) => roomsController.listeningRoom, (_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (_scrollController.hasClients) {
        await Future.delayed(const Duration(milliseconds: 100));
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
    roomsController.listenRoomById(roomId: roomId);
  }

  void _reactionFailureSetup(BuildContext context) {
    reaction(
      (_) => roomsController.failure,
      (_) => roomsController.failure.map(
        (message) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(message),
          ),
        ),
      ),
    );
  }

  Future<void> _sendPhrase() async {
    final appController = getIt<AppController>();
    await roomsController.sendPhrase(roomId: roomId, userId: appController.user!.id, phrase: _phraseController.text);
    if (roomsController.failure.isNone()) {
      _phraseController.clear();
    }
  }
}
