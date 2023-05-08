import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../../config/const.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({
    super.key,
  });

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: darkGray,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            bottom: 50,
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: const RiveAnimation.asset(
                'assets/rive/planet.riv',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: const RiveAnimation.asset(
                'assets/rive/obstacle.riv',
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
