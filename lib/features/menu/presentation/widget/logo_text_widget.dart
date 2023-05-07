import 'package:flutter/material.dart';

class LogoTextdWidget extends StatelessWidget {
  final int _number;

  const LogoTextdWidget({
    super.key,
    required int number1,
  }) : _number = number1;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_number',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
