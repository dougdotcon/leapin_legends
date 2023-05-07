import 'package:flappy_game/config/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final String text;
  final Color color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.08),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 18,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
