import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:equatable/equatable.dart';

class GameRoom extends Equatable {
  final String? id;
  final String? name;
  final List<String>? adminsIds;
  final bool? someoneIsTapping;
  final String? lastTappedId;
  final List<String>? playersIds;
  final List<Phrase>? history;

  const GameRoom({
    this.id,
    this.name,
    this.adminsIds,
    this.history,
    this.playersIds,
    this.someoneIsTapping,
    this.lastTappedId,
  });

  @override
  List<Object?> get props => [id, name, adminsIds, playersIds, history, someoneIsTapping, lastTappedId];

  GameRoom copyWith({
    String? id,
    String? name,
    List<String>? adminsIds,
    List<String>? playersIds,
    List<Phrase>? history,
    bool? someoneIsTapping,
    String? lastTappedId
  }) =>
      GameRoom(
        id: id ?? this.id,
        name: name ?? this.name,
        adminsIds: adminsIds ?? this.adminsIds,
        playersIds: playersIds ?? this.playersIds,
        history: history ?? this.history,
        someoneIsTapping: someoneIsTapping ?? this.someoneIsTapping,
        lastTappedId: lastTappedId ?? this.lastTappedId,
      );
}
