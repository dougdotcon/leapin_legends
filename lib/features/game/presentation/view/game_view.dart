import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart' as rive;

import 'package:flappy_game/config/const.dart';
import 'package:flappy_game/config/enums.dart';

import '../blocs/bloc/game_bloc.dart';
import '../blocs/timer/timer_cubit.dart';
import '../widgets/game_header_widget.dart';
import '../widgets/game_widget.dart';
import '../widgets/result_widget.dart';

void main() => runApp(const GameView());

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final rive.RiveAnimationController _heroController = rive.SimpleAnimation('Run', autoplay: false);
  final rive.RiveAnimationController _groundController = rive.SimpleAnimation('Run', autoplay: false);
  final rive.RiveAnimationController _backgroundController = rive.SimpleAnimation('Run', autoplay: false);

  Color recordColor = Colors.white.withOpacity(0.08);

  @override
  void initState() {
    _backgroundController.isActive = false;
    _groundController.isActive = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        backgroundColor: darkGray,
        body: SafeArea(
          child: BlocBuilder<TimerCubit, TimerState>(
            builder: (context, timerState) {
              return BlocConsumer<GameBloc, GameState>(
                listener: (context, gameStateListener) {
                  if (gameStateListener.gameStatus == GameStatus.lose) {
                    context.read<GameBloc>().add(UpdateUserRecord(record: gameStateListener.result.toInt()));
                    context.read<TimerCubit>().stop();
                    _heroController.isActive = false;
                    _groundController.isActive = false;
                    _backgroundController.isActive = false;
                  }
                  if (timerState.time == 5000 || timerState.time == 10000 || timerState.time == 20000) {
                    context.read<GameBloc>().add(ChangeDifficulity());
                  }
                  if (gameStateListener.recordStatus == RecordStatus.newRecord) {
                    updateRecordColor(gold);
                  }
                },
                listenWhen: (previous, current) {
                  if (previous.gameStatus == GameStatus.lose && current.gameStatus == GameStatus.started) {
                    updateRecordColor(textGray);
                    context.read<GameBloc>().add(InitNewGame());
                  }
                  return true;
                },
                builder: (context, gameState) {
                  if (timerState.status == TimerStatus.ticking) {
                    Future.delayed(const Duration(milliseconds: 200)).then((value) {
                      context.read<GameBloc>().add(UpdateHeroPosition());
                      context.read<GameBloc>().add(UpdateObstaclePositions());
                      context.read<GameBloc>().add(CheckColission());
                    });
                  }
                  return Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(30.h),
                        GameHeader(
                          cupTap: () {},
                          infoTap: () => infoDialog(context),
                        ),
                        Gap(40.h),
                        ResultWidget(
                          record: gameState.record.toInt(),
                          result: gameState.result.toInt(),
                          recordColor: recordColor,
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(
                                period: const Duration(milliseconds: 5000),
                              ),
                            )
                            .shake(),
                        GameWidget(
                            backgroundController: _backgroundController,
                            groundController: _groundController,
                            heroController: _heroController,
                            gameState: gameState,
                            onTap: gameTap),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> infoDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          actions: [
            Container(
              height: 300,
              child: Column(
                children: [],
              ),
            )
          ],
        );
      },
    );
  }

  void updateRecordColor(Color color) {
    setState(() {
      recordColor = color;
    });
  }

  void gameTap() {
    var gameState = context.read<GameBloc>().state;
    var timerState = context.read<TimerCubit>().state;

    if (timerState.status == TimerStatus.off) {
      context.read<TimerCubit>().start();
      context.read<GameBloc>().add(UpdateGameStatus(gameStatus: GameStatus.started));
      _heroController.isActive = true;
      _backgroundController.isActive = true;
      _groundController.isActive = true;
    }

    if (!gameState.isJumping && gameState.gameStatus != GameStatus.lose && gameState.heroPosition == 0) {
      context.read<GameBloc>().add(Jump());
    }
  }
}
