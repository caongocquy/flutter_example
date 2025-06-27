part of 'math_bloc.dart';

sealed class MathEvent extends Equatable {
  const MathEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends MathEvent {
  const IncrementEvent();

  @override
  List<Object> get props => [];
}

class DecrementEvent extends MathEvent {
  const DecrementEvent();

  @override
  List<Object> get props => [];
}
