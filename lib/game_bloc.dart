import 'dart:async';

import 'package:async/async.dart';
import 'package:lab_5_showcase/users_api.dart';

import 'game.dart';

class GameBloc {
  GameBloc() {
    _startNextGame();
  }

  Game? _previousGame;
  final _currentGameController = StreamController<Game>.broadcast();
  final _answerController = StreamController<bool>.broadcast();
  final _previousGameController = StreamController<Game>.broadcast();

  void _startNextGame() {
    fetchRandomUser().then((user) {
      final newGame = Game(user);
      _currentGameController.add(newGame);

      if (_previousGame != null) {
        _previousGameController.add(_previousGame!);
      }

      _previousGame = newGame;
    });
  }

  Stream<Game> get currentGame => _currentGameController.stream;

  Stream<Game> get previousGame => _previousGameController.stream;

  Stream<bool> get isCorrectAnswer =>
      StreamZip([currentGame, _answerController.stream]).map((pair) {
        final game = pair[0] as Game;
        final answer = pair[1] as bool;

        return game.correctAnswer == answer;
      });

  void answer(bool isCorrect) {
    _answerController.add(isCorrect);
    _startNextGame();
  }
}
