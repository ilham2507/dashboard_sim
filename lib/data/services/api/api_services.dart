class ApiServices {
  static String url = "192.168.1.73";
  static const int port = 8000;

  static String get baseUrl => "http://$url:$port/api";
  static String get imageUrl => "http://$url:$port/foto/";
}
