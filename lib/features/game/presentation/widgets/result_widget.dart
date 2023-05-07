// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ResultWidget extends StatelessWidget {
  final int result;
  final int record;
  final Color recordColor;
  const ResultWidget({
    Key? key,
    required this.result,
    required this.record,
    required this.recordColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.rocket_launch_rounded,
              size: 25,
              color: Colors.white,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(
                    period: const Duration(milliseconds: 5000),
                  ),
                )
                .shake(),
            Gap(10.h),
            Text(
              'result',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gap(10.h),
            Text(
              '$result',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Gap(5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                'assets/images/cup.png',
                height: 17,
                color: recordColor,
                width: 17,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(
                      period: const Duration(milliseconds: 5000),
                    ),
                  )
                  .shake(),
            ),
            Gap(10.h),
            Text(
              'record',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: recordColor,
                    fontSize: 17,
                  ),
            ),
            Gap(10.h),
            Text(
              '$record',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: recordColor,
                    fontSize: 17,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
