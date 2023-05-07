import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap(5.h),
        SizedBox(
          height: 50.h,
          width: 50.w,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 5,
          ),
        ),
        Gap(40.h),
      ],
    );
  }
}
