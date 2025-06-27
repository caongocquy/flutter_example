part of 'locale_bloc.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object?> get props => [];
}

class LoadSavedLocale extends LocaleEvent {
  const LoadSavedLocale();
}

class ChangeLocale extends LocaleEvent {
  final Locale locale;
  final BuildContext context;

  const ChangeLocale({required this.locale, required this.context});

  @override
  List<Object?> get props => [locale];
}
