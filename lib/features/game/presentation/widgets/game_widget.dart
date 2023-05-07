import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rive/rive.dart';

import '../../../../config/const.dart';
import '../blocs/bloc/game_bloc.dart';

class GameWidget extends StatelessWidget {
  final RiveAnimationController backgroundController;
  final RiveAnimationController groundController;
  final RiveAnimationController heroController;
  final GameState gameState;
  final Function()? onTap;

  const GameWidget({
    Key? key,
    required this.backgroundController,
    required this.groundController,
    required this.heroController,
    required this.gameState,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 340,
              child: SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: const RiveAnimation.asset(
                  'assets/rive/planet.riv',
                ),
              ),
            ),
            Positioned(
              bottom: 145,
              child: SizedBox(
                height: 255,
                width: MediaQuery.of(context).size.width,
                child: RiveAnimation.asset(
                  'assets/rive/background.riv',
                  controllers: [backgroundController],
                ),
              ),
            ),
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
                  controllers: [groundController],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              child: Center(
                child: const Icon(
                  Icons.touch_app_rounded,
                  size: 70,
                  color: Colors.white,
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(
                        period: const Duration(milliseconds: 5000),
                      ),
                    )
                    .shake(),
              ),
            ),
            Positioned(
              bottom: gameState.heroPosition + 200,
              left: 50,
              child: SizedBox(
                height: 100,
                width: 100,
                child: RiveAnimation.asset(
                  'assets/rive/hero.riv',
                  controllers: [heroController],
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
          ],
        ),
      ),
    );
  }
}
