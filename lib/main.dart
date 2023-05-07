import 'package:flappy_game/config/const.dart';
import 'package:flappy_game/features/game/presentation/blocs/bloc/game_bloc.dart';
import 'package:flappy_game/features/game/presentation/blocs/timer/timer_cubit.dart';
import 'package:flappy_game/features/menu/presentation/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flappy_game/config/route.dart' as route;

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: darkGray,
    systemNavigationBarDividerColor: darkGray,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 781.0909090909091),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TimerCubit()),
            BlocProvider(create: (context) => GameBloc()..add(InitGame())),
            BlocProvider(create: (context) => UserBloc()..add(const AuthUserEvent())),
          ],
          child: MaterialApp(
            title: 'MemoryGame',
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              textTheme: TextTheme(
                titleLarge: GoogleFonts.plusJakartaSans(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  color: darkGray,
                ),
                titleSmall: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                titleMedium: GoogleFonts.plusJakartaSans(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                displayLarge: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                labelMedium: GoogleFonts.plusJakartaSans(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                labelSmall: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                displayMedium: GoogleFonts.plusJakartaSans(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                headlineMedium: GoogleFonts.plusJakartaSans(
                  fontSize: 33.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            initialRoute: route.menu,
            onGenerateRoute: route.controller,
          ),
        );
      },
    );
  }
}
