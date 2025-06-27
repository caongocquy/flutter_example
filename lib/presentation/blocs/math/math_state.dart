part of 'math_bloc.dart';

sealed class MathState extends Equatable {
  final int? result;
  const MathState({this.result = 0});
  MathState copyWith({int? result});
  @override
  List<Object> get props => [];
}

final class MathInitial extends MathState {
  const MathInitial() : super();

  @override
  List<Object> get props => [];
  @override
  MathState copyWith({int? result}) {
    return MathInitial();
  }
}

final class MathResult extends MathState {
  const MathResult(int result) : super(result: result);

  @override
  List<Object> get props => [result ?? 0];

  @override
  MathState copyWith({int? result}) {
    return MathResult(result ?? this.result!);
  }
}

final class MathError extends MathState {
  final String message;
  const MathError(this.message) : super();

  @override
  List<Object> get props => [message];

  @override
  MathState copyWith({int? result}) {
    return MathError(message);
  }
}
