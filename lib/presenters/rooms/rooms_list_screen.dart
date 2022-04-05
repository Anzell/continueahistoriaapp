import 'package:continueahistoriaapp/di/injector.dart';
import 'package:continueahistoriaapp/domain/entities/resumed_game_room.dart';
import 'package:continueahistoriaapp/presenters/app/controllers/app_controller.dart';
import 'package:continueahistoriaapp/presenters/rooms/controllers/rooms_controller.dart';
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
    _setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      itemBuilder: (context, index) => _CardResumedRoom(
                        resumedGameRoom: roomsController.listResumedRooms[index],
                      ),
                    )
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
        (message) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(message),
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
                Text(resumedGameRoom.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
