import 'dart:async';
import 'package:flappy_game/config/const.dart';
import 'package:flappy_game/config/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../blocs/bloc/game_bloc.dart';
import '../blocs/timer/timer_cubit.dart';

void main() => runApp(const GameView());

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late RiveAnimationController _heroController = SimpleAnimation('');
  late RiveAnimationController _groundController = SimpleAnimation('');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var gameState = context.read<GameBloc>().state;
        var timerState = context.read<TimerCubit>().state;

        if (timerState.status == TimerStatus.off) {
          context.read<TimerCubit>().start();
          context.read<GameBloc>().add(UpdateGameStatus(gameStatus: GameStatus.started));
          _heroController = SimpleAnimation('Run', autoplay: true);
          _groundController = SimpleAnimation('Run', autoplay: true);
        }

        if (!gameState.isJumping && gameState.gameStatus != GameStatus.lose && gameState.heroPosition == 0) {
          context.read<GameBloc>().add(Jump());
        }
      },
      child: Scaffold(
        body: BlocBuilder<TimerCubit, TimerState>(
          builder: (context, timerState) {
            return BlocConsumer<GameBloc, GameState>(
              listener: (context, gameStateListener) {
                if (gameStateListener.gameStatus == GameStatus.lose) {
                  context.read<TimerCubit>().stop();
                  _heroController = SimpleAnimation('', autoplay: false);
                  _groundController = SimpleAnimation('', autoplay: false);
                }
                if (timerState.time == 5000 || timerState.time == 10000 || timerState.time == 20000) {
                  context.read<GameBloc>().add(ChangeDifficulity());
                }
              },
              listenWhen: (previous, current) {
                if (previous.gameStatus == GameStatus.lose && current.gameStatus == GameStatus.started) {
                  context.read<GameBloc>().add(InitNewGame());
                }
                return true;
              },
              builder: (context, gameState) {
                if (timerState.status == TimerStatus.ticking) {
                  Future.delayed(const Duration(milliseconds: 15)).then((value) {
                    context.read<GameBloc>().add(UpdateHeroPosition());
                    context.read<GameBloc>().add(UpdateObstaclePositions());
                    context.read<GameBloc>().add(CheckColission());
                  });
                }
                return Container(
                  color: Colors.white,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: darkGray,
                          height: 205,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        bottom: 145,
                        child: SizedBox(
                          height: 87,
                          width: MediaQuery.of(context).size.width,
                          child: RiveAnimation.asset(
                            'assets/rive/ground.riv',
                            controllers: [_groundController],
                          ),
                        ),
                      ),
                      const RiveAnimation.asset(
                        'assets/rive/background.riv',
                      ),
                      Positioned(
                        bottom: 100,
                        child: Text('result: ${gameState.result.toInt()}'),
                      ),
                      Positioned(
                        bottom: gameState.heroPosition + 200,
                        left: 50,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: RiveAnimation.asset(
                            'assets/rive/hero.riv',
                            controllers: [_heroController],
                            onInit: (_) => SimpleAnimation('Jump'),
                          ),
                        ),
                      ),
                      ...gameState.obstaclePositions.map((position) {
                        return Positioned(
                          bottom: 200,
                          left: position,
                          child: const SizedBox(
                            height: 60,
                            width: 60,
                            child: RiveAnimation.asset(
                              'assets/rive/obstacle.riv',
                            ),
                          ),
                        );
                      }),
                      if (gameState.gameStatus == GameStatus.lose) Container()
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
