import 'dart:async';
import 'package:flappy_game/config/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/game_bloc.dart';
import '../blocs/timer/timer_cubit.dart';

void main() => runApp(const TRexGame());

class TRexGame extends StatefulWidget {
  const TRexGame({super.key});

  @override
  State<StatefulWidget> createState() => _TRexGameState();
}

class _TRexGameState extends State<TRexGame> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var gameState = context.read<GameBloc>().state;
        var timerState = context.read<TimerCubit>().state;

        if (timerState.status == TimerStatus.off) {
          context.read<TimerCubit>().start();
          context.read<GameBloc>().add(UpdateGameStatus(gameStatus: GameStatus.started));
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
                    children: [
                      Positioned(bottom: 100, child: Text('result: ${gameState.result.toInt()}')),
                      Positioned(
                        bottom: gameState.heroPosition,
                        left: 50,
                        child: Image.asset(
                          'assets/images/hero.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      ...gameState.obstaclePositions.map((position) {
                        return Positioned(
                          bottom: 0,
                          left: position,
                          child: Image.asset(
                            'assets/images/hero.png',
                            height: 100,
                            width: 100,
                          ),
                        );
                      }),
                      if (gameState.gameStatus == GameStatus.lose)
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              color: Colors.black,
                              child: const Center(
                                child: Text(
                                  'GAME OVER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
