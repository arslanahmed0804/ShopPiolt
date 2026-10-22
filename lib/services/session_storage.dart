import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_user.dart';

/// Token + user ko device par save karta hai taake app restart par login na karna pade.
/// Production mein flutter_secure_storage use karna behtar hai (token encrypted rehta hai).
class SessionStorage {
  static const _key = 'auth_session';

  Future<void> save(AuthSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(session.toJson()));
  }

  Future<AuthSession?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    try {
      return AuthSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      await prefs.remove(_key);
      return null;
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}