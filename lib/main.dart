import 'package:flappy_game/features/game/presentation/blocs/bloc/game_bloc.dart';
import 'package:flappy_game/features/game/presentation/blocs/timer/timer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/game/presentation/view/game_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GameBloc()),
        BlocProvider(create: (context) => TimerCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TRexGame(),
      ),
    );
  }
}
