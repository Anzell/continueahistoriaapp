import 'package:equatable/equatable.dart';

class ResumedGameRoom extends Equatable {
  final String id;
  final String title;
  final int phrasesNumber;
  final int playersNumber;

  ResumedGameRoom({required this.id, required this.phrasesNumber, required this.playersNumber, required this.title});

  @override
  List<Object> get props => [id, phrasesNumber, playersNumber, title];
}