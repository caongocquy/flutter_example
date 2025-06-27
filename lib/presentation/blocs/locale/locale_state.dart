part of 'locale_bloc.dart';

sealed class LocaleState extends Equatable {
  const LocaleState();

  @override
  List<Object?> get props => [];
}

class LocaleInitial extends LocaleState {
  const LocaleInitial();
}

class LocaleLoaded extends LocaleState {
  final Locale locale;

  const LocaleLoaded({required this.locale});

  @override
  List<Object?> get props => [locale];
}
