import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../menu/presentation/blocs/user/user_bloc.dart';

class LeaderboardHeader extends StatelessWidget {
  const LeaderboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              size: 28,
              Icons.rocket_launch_rounded,
              color: Colors.white,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(
                    period: const Duration(milliseconds: 5000),
                  ),
                )
                .shake(),
            Gap(20.w),
            Text(
              'Top 10 records',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        Gap(40.h),
        Row(
          children: [
            Gap(5.w),
            const Icon(
              Icons.person_rounded,
              size: 30,
              color: Colors.white,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(
                    period: const Duration(milliseconds: 5000),
                  ),
                )
                .shake(),
            Gap(20.w),
            Text(
              context.read<UserBloc>().state.user!.name,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}
