import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import '../../../../config/const.dart';
import '../blocs/bloc/game_bloc.dart';
import '../widgets/leaderboard_header_widget.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  @override
  void initState() {
    context.read<GameBloc>().add(GetTimeLeaderboard());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400.w),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: const BoxDecoration(color: darkGray),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(40.h),
              const LeaderboardHeader(),
              Gap(20.h),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.leaderboard.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index + 1 < 4 ? gold : Colors.white,
                                ),
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Text(
                                  '${index + 1}',
                                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: darkGray, fontWeight: FontWeight.w900),
                                )),
                              ),
                              Text(
                                state.leaderboard[index].name,
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                '${state.leaderboard[index].record}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          Gap(15.h),
                        ],
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: darkGray,
                  ),
                ),
              ),
              Gap(60.h),
            ],
          ),
        ),
      ),
    );
  }
}
