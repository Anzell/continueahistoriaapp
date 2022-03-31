import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:equatable/equatable.dart';

class GameRoom extends Equatable {
  final String? id;
  final String? name;
  final List<String>? adminsIds;
  final List<String>? playersIds;
  final List<Phrase>? history;

  const GameRoom({
    this.id,
    this.name,
    this.adminsIds,
    this.history,
    this.playersIds,
  });

  @override
  List<Object?> get props => [id, name, adminsIds, playersIds, history];
}
