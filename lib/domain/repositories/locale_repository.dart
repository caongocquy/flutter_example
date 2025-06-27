import 'package:flutter/widgets.dart';

abstract class LocaleRepository {
  Future<void> saveLocale(Locale locale);
  Future<Locale?> loadLocale();
}
