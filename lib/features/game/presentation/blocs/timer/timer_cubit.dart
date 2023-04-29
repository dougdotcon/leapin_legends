import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/enums.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState(status: TimerStatus.off, time: 0));

  late Timer _timer;

  void start() => {
        state.time > 0 ? {stop(), reset()} : emit(state.copyWith(time: 0)),
        _timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
          emit(state.copyWith(time: state.time + 15, status: TimerStatus.ticking));
        })
      };
  void stop() => {
        _timer.cancel(),
        emit(state.copyWith(status: TimerStatus.off)),
      };
  void reset() => {
        emit(state.copyWith(time: 0, status: TimerStatus.off)),
      };
}
