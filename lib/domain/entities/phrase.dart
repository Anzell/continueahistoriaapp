import 'package:equatable/equatable.dart';

class Phrase extends Equatable {
  final String? senderId;
  final DateTime? sendAt;
  final String? phrase;

  const Phrase({this.phrase, this.senderId, this.sendAt});

  @override
  List<Object?> get props => [senderId, phrase, sendAt];
}