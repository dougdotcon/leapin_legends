part of 'timer_cubit.dart';

class TimerState extends Equatable {
  const TimerState({
    required this.time,
    required this.status,
  });

  final int time;
  final TimerStatus status;

  @override
  List<Object> get props => [time, status];

  TimerState copyWith({
    int? time,
    TimerStatus? status,
  }) {
    return TimerState(
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}
