import 'dart:math';

import 'user.dart';

class Game {
  final User user;
  final Gender suggestedGender;
  final int suggestedAge;

  Game(this.user)
      : suggestedGender =
            _shouldBeCorrect() ? user.gender : _oppositeGender(user.gender),
        suggestedAge = _shouldBeCorrect() ? user.age : _getSimilarAge(user.age);

  bool get doesAgeMatch => user.age == suggestedAge;
  bool get doesGenderMatch => user.gender == suggestedGender;
  bool get correctAnswer => doesAgeMatch && doesGenderMatch;
}

bool _shouldBeCorrect() {
  return Random().nextBool();
}

Gender _oppositeGender(Gender gender) {
  return gender == Gender.male ? Gender.female : Gender.male;
}

int _getSimilarAge(int age) {
  final rng = Random();
  final up = rng.nextBool();
  final increment = rng.nextInt(3) + 1;

  return up ? age + increment : age - increment;
}
