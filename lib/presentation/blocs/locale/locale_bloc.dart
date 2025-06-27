import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/usecases/locale/load_locale.dart';
import 'package:test_blocs/domain/usecases/locale/save_locale.dart';

part 'locale_event.dart';
part 'locale_state.dart';

@injectable
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final LoadLocale loadLocale;
  final SaveLocale saveLocale;

  LocaleBloc({required this.loadLocale, required this.saveLocale})
    : super(LocaleInitial()) {
    on<LoadSavedLocale>(_onLoadSavedLocale);
    on<ChangeLocale>(_onChangeLocale);
  }

  Future<void> _onLoadSavedLocale(
    LoadSavedLocale event,
    Emitter<LocaleState> emit,
  ) async {
    final saved = await loadLocale();
    if (saved != null) emit(LocaleLoaded(locale: saved));
  }

  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    await saveLocale(event.locale);
    emit(LocaleLoaded(locale: event.locale));
  }
}
