import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(TRexGame());

class TRexGame extends StatefulWidget {
  @override
  _TRexGameState createState() => _TRexGameState();
}

class _TRexGameState extends State<TRexGame> {
  double _trexYPosition = 0;
  bool _isJumping = false;
  bool _gameOver = false;
  late Timer _timer;
  final List<double> _obstaclePositions = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _updateTrexPosition();
      _updateObstaclePositions();
      _checkCollision();
    });
  }

  void _updateTrexPosition() {
    setState(() {
      if (_isJumping) {
        _trexYPosition += 8;
        if (_trexYPosition > 120) {
          _isJumping = false;
        }
      } else if (_trexYPosition > 0) {
        _trexYPosition -= 3;
      }
    });
  }

  void _updateObstaclePositions() {
    setState(() {
      for (int i = 0; i < _obstaclePositions.length; i++) {
        _obstaclePositions[i] -= 5;
      }
      if (_obstaclePositions.isEmpty || _obstaclePositions.last < 500) {
        final position = math.Random().nextDouble() * 450 + 700;
        _obstaclePositions.add(position);
      }
    });
  }

  void _checkCollision() {
    for (final obstaclePosition in _obstaclePositions) {
      if (obstaclePosition < 50 && obstaclePosition + 80 > 20 && _trexYPosition + 20 < 50) {
        _gameOver = true;
        _timer.cancel();
      }
    }
  }

  void _handleTap() {
    if (!_isJumping && !_gameOver) {
      _isJumping = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                bottom: _trexYPosition,
                left: 50,
                child: Image.asset(
                  'assets/images/hero.png',
                  height: 100,
                  width: 100,
                ),
              ),
              ..._obstaclePositions.map((position) {
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
              if (_gameOver)
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
