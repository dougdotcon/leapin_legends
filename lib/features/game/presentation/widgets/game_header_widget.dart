import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class GameHeader extends StatelessWidget {
  final Function()? cupTap;
  final Function()? infoTap;
  const GameHeader({
    Key? key,
    required this.cupTap,
    required this.infoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(30.w),
        InkWell(
          onTap: cupTap,
          child: SizedBox(
            height: 25,
            width: 25,
            child: Image.asset('assets/images/cup.png'),
          )
              .animate(
                onPlay: (controller) => controller.repeat(
                  period: const Duration(milliseconds: 5000),
                ),
              )
              .shake(),
        ),
        const Spacer(),
        InkWell(
          onTap: infoTap,
          child: const Icon(
            Icons.info,
            size: 30,
            color: Colors.white,
          )
              .animate(
                onPlay: (controller) => controller.repeat(
                  period: const Duration(milliseconds: 5000),
                ),
              )
              .shake(),
        ),
        Gap(30.w),
      ],
    );
  }
}
