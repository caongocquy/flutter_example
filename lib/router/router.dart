enum AppRoute {
  splashScreen('/'),
  login('/login'),
  home('/home');

  final String path;
  const AppRoute(this.path);
  String pathWithParams(Map<String, String> params) {
    var result = path;
    params.forEach((key, value) {
      result = result.replaceAll(':$key', value);
    });
    return result;
  }
}
