import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/const.dart';

void infoDialog(context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.90),
        elevation: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            width: MediaQuery.of(context).size.width,
            height: 300.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Game info',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: darkGray,
                          ),
                    ),
                    const Icon(
                      Icons.info,
                      color: darkGray,
                      size: 31,
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            period: const Duration(milliseconds: 5000),
                          ),
                        )
                        .shake(),
                  ],
                ),
                Gap(30.h),
                Row(
                  children: [
                    const Icon(
                      Icons.touch_app_rounded,
                      size: 30,
                      color: darkGray,
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            period: const Duration(milliseconds: 5000),
                          ),
                        )
                        .shake(),
                    Gap(8.w),
                    Flexible(
                      child: Text(
                        'Tap bottom of the screen to jump',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: darkGray,
                            ),
                      ),
                    ),
                  ],
                ),
                Gap(13.h),
                Row(
                  children: [
                    Gap(4.w),
                    SizedBox(
                      height: 22,
                      width: 22,
                      child: Image.asset(
                        'assets/images/cup.png',
                        color: darkGray,
                      ),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            period: const Duration(milliseconds: 5000),
                          ),
                        )
                        .shake(),
                    Gap(8.w),
                    Flexible(
                      child: Text(
                        'Tap to open leaderboard',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: darkGray,
                            ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: darkGray,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
