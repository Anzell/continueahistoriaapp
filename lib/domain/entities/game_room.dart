import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

  GameRoom copyWith({
    String? id,
    String? name,
    List<String>? adminsIds,
    List<String>? playersIds,
    List<Phrase>? history,
  }) =>
      GameRoom(
        id: id ?? this.id,
        name: name ?? this.name,
        adminsIds: adminsIds ?? this.adminsIds,
        playersIds: playersIds ?? this.playersIds,
        history: history ?? this.history,
      );
}
