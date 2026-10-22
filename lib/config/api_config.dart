class ApiConfig {
  /// Apne backend ka base URL (jahan `app.use("/api", ...)` mount hai).
  /// Auth routes: POST {baseUrl}/auth/register  aur  {baseUrl}/auth/login
  ///
  /// Run karte waqt badal sakte ho:
  ///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5000/api   (Android emulator)
  ///   flutter run --dart-define=API_BASE_URL=http://192.168.1.10:5000/api (real phone, same WiFi)
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000/api',
  );

  /// Agar tumne routes `app.use("/api/users", authRoutes)` jaisa mount kiye hain to yahan badlo.
  static const String authPath = '/auth';

  static const Duration timeout = Duration(seconds: 15);
}