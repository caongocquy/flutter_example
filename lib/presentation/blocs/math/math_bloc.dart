import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/repositories/math_repository.dart';

part 'math_event.dart';
part 'math_state.dart';

@injectable
class MathBloc extends Bloc<MathEvent, MathState> {
  final MathRepository mathRepository;

  MathBloc({required this.mathRepository}) : super(MathInitial()) {
    on<IncrementEvent>(onIncrementEvent);
    on<DecrementEvent>(onDecrementEvent);
  }

  Future<void> onIncrementEvent(
    IncrementEvent event,
    Emitter<MathState> emit,
  ) async {
    try {
      final current = state.result ?? 0;
      final result = mathRepository.increment(current);
      emit(MathResult(result));
    } catch (e) {
      emit(MathError('An error occurred: ${e.toString()}'));
    }
  }

  Future<void> onDecrementEvent(
    DecrementEvent event,
    Emitter<MathState> emit,
  ) async {
    try {
      final current = state.result ?? 0;
      final result = mathRepository.decrement(current);
      emit(MathResult(result));
    } catch (e) {
      emit(MathError('An error occurred: ${e.toString()}'));
    }
  }
}
