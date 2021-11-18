import 'package:flutter/material.dart';
import 'package:lab_5_showcase/game.dart';
import 'package:provider/provider.dart';

import 'game_bloc.dart';
import 'user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);

    return StreamBuilder<bool>(
        stream: bloc.isCorrectAnswer,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: snapshot.hasData
                ? (snapshot.data! ? Colors.green[100] : Colors.red[100])
                : null,
            appBar: AppBar(
              title: const Text('Guessing app'),
            ),
            body: Center(
              child: Column(
                children: [
                  StreamBuilder<Game>(
                      stream: bloc.previousGame,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? PreviousGameCard(
                                game: snapshot.data!,
                              )
                            : const SizedBox.shrink();
                      }),
                  StreamBuilder<Game>(
                      stream: bloc.currentGame,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? CurrentGameCard(
                                game: snapshot.data!,
                              )
                            : const SizedBox.shrink();
                      }),
                ],
              ),
            ),
            floatingActionButton: const ButtonsBlock(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}

class ButtonsBlock extends StatelessWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              bloc.answer(false);
            },
            tooltip: 'No',
            child: const Icon(Icons.cancel),
            backgroundColor: Colors.red,
          ),
          FloatingActionButton(
            onPressed: () {
              bloc.answer(true);
            },
            tooltip: 'Yes',
            child: const Icon(Icons.check),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class PreviousGameCard extends StatelessWidget {
  final Game game;

  const PreviousGameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              game.user.imageUrl,
            ),
            radius: 50,
          ),
          Text(
            game.user.name,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            'Suggested gender: ${stringify(game.suggestedGender)}, actual: ${stringify(game.user.gender)}',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            'Suggested age: ${game.suggestedAge}, actual: ${game.user.age}',
            style: const TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}

class CurrentGameCard extends StatelessWidget {
  final Game game;

  const CurrentGameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              game.user.imageUrl,
            ),
            radius: 100,
          ),
          Text(
            game.user.name,
            style: const TextStyle(
              fontSize: 32,
            ),
          ),
          Text(
            'Gender: ${stringify(game.suggestedGender)}',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            'Age: ${game.suggestedAge}',
            style: const TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}
