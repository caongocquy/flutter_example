abstract class LocaleLocalDataSource {
  Future<void> saveLocale(String code);
  Future<String?> loadLocale();
}
