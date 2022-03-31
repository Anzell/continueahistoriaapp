import 'package:continueahistoriaapp/domain/entities/phrase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should equatable working", () {
    final obj1 = Phrase(senderId: "validId", phrase: "um cara que", sendAt: DateTime(2021,10,10));
    final obj2 = Phrase(senderId: "validId", phrase: "um cara que", sendAt: DateTime(2021,10,10));
    expect(obj1, equals(obj2));
  });
}