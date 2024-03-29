import 'package:continueahistoriaapp/core/themes/app_colors.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/room_config_screen.dart';
import 'package:continueahistoriaapp/presenters/widgets/icon_button.dart';
import 'package:continueahistoriaapp/presenters/widgets/input_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../di/injector.dart';

enum _roomOptions { Configuration }

class RoomScreen extends StatelessWidget {
  final RoomsController roomsController;
  final String roomId;
  final appController = getIt<AppController>();
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
        actions: [
          PopupMenuButton(
            onSelected: (_roomOptions selected) {
              switch (selected) {
                case _roomOptions.Configuration:
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RoomConfigScreen(room: roomsController.listeningRoom!)));
                  break;
              }
            },
            child: const Icon(Icons.more_vert),
            itemBuilder: (context) =>
                [const PopupMenuItem(value: _roomOptions.Configuration, child: Text("Configurações da Sala"))],
          )
        ],
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
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              child: Observer(builder: (builder) {
                if (roomsController.listeningRoom != null && roomsController.listeningRoom!.someoneIsTapping != null) {
                  if (roomsController.listeningRoom!.someoneIsTapping! &&
                      roomsController.listeningRoom!.lastTappedId == appController.user!.id) {
                    return CustomInputForm(
                      placeholder: "continue a história",
                      controller: _phraseController,
                      suffixIconButton: IconButton(
                        icon: const Icon(Icons.send, color: Colors.black),
                        onPressed: () async => _sendPhrase(),
                      ),
                    );
                  } else if (roomsController.listeningRoom!.someoneIsTapping!) {
                    return Text(
                      "Alguém está digitando, aguarde...",
                      textAlign: TextAlign.center,
                    );
                  } else if (roomsController.listeningRoom!.someoneIsTapping! == false &&
                      roomsController.listeningRoom!.lastTappedId == appController.user!.id) {
                    return Text(
                      "Aguarde outro jogador continuar a história",
                      textAlign: TextAlign.center,
                    );
                  }
                }
                return _CustomSendMessageButton(
                  onTap: () {
                    roomsController.lockRoom(roomId: roomId, userId: appController.user!.id!);
                  },
                );
              },),
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
        (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
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

class _CustomSendMessageButton extends StatelessWidget {
  final Function() onTap;
  const _CustomSendMessageButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: AppColors.darkGreen,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Solicitar para enviar mensagem", style: TextStyle(color: AppColors.beige),textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
