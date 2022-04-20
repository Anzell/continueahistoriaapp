import 'package:continueahistoriaapp/core/themes/app_colors.dart';
import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/new_room_form_screen.dart';
import 'package:continueahistoriaapp/presenters/rooms/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({Key? key}) : super(key: key);

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  final appController = getIt.get<AppController>();
  final roomsController = getIt.get<RoomsController>();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _reactionFailureSetup();
    _initControllers();
  }

  Future<void> _initControllers() async {
    _setLoading(true);
    await roomsController.getRoomsByPlayerId(userId: appController.user!.id);
    _reactionServerFailures();
    appController.listenFailures();
    _setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewRoomFormScreen(
                onCreateRoom: _initControllers,
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text("Olá ${appController.user!.username}"),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: roomsController.listResumedRooms.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _goToRoomScreen(roomId: roomsController.listResumedRooms[index].id),
                        child: _CardResumedRoom(
                          resumedGameRoom: roomsController.listResumedRooms[index],
                        ),
                      ),
                    ),
                    roomsController.listResumedRooms.isEmpty
                        ? Text("Você ainda não participa de nenhuma sala")
                        : SizedBox()
                  ],
                ),
              ),
            ),
    );
  }

  void _reactionFailureSetup() {
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

  void _reactionServerFailures() {
    reaction(
      (_) => appController.failure,
      (_) => appController.failure.map(
        (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _goToRoomScreen({required String roomId}) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => RoomScreen(roomsController: roomsController, roomId: roomId),
        ),
      );
}

class _CardResumedRoom extends StatelessWidget {
  final ResumedGameRoom resumedGameRoom;
  const _CardResumedRoom({Key? key, required this.resumedGameRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resumedGameRoom.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text("${resumedGameRoom.playersNumber} Jogadores"),
                Text("${resumedGameRoom.phrasesNumber} frases")
              ],
            ),
            const Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
