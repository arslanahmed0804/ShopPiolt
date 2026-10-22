import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../services/session_storage.dart';

/// Login state ka single source. UI isko ListenableBuilder se sunti hai.
class AuthController extends ChangeNotifier {
  final AuthRepository _repo;
  final SessionStorage _storage;

  AuthController(this._repo, this._storage);

  AuthUser? user;
  String? token; // baqi API calls: headers['Authorization'] = 'Bearer $token'
  bool initializing = true;
  bool busy = false;
  String? error;

  bool get isLoggedIn => user != null && token != null;

  /// App start par: saved session wapis lo (agar token expire nahi hua).
  Future<void> restore() async {
    final s = await _storage.read();
    if (s != null && !_isExpired(s.token)) {
      user = s.user;
      token = s.token;
    } else if (s != null) {
      await _storage.clear();
    }
    initializing = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    return _run(() async {
      final session = await _repo.login(email.trim().toLowerCase(), password);
      await _storage.save(session);
      user = session.user;
      token = session.token;
    });
  }

  /// Backend register par token nahi deta, isliye register ke baad auto-login.
  Future<bool> register(String name, String email, String password) async {
    return _run(() async {
      final cleanEmail = email.trim().toLowerCase();
      await _repo.register(name.trim(), cleanEmail, password);
      final session = await _repo.login(cleanEmail, password);
      await _storage.save(session);
      user = session.user;
      token = session.token;
    });
  }

  Future<void> logout() async {
    await _storage.clear();
    user = null;
    token = null;
    error = null;
    notifyListeners();
  }

  void clearError() {
    if (error == null) return;
    error = null;
    notifyListeners();
  }

  Future<bool> _run(Future<void> Function() action) async {
    busy = true;
    error = null;
    notifyListeners();
    try {
      await action();
      return true;
    } on AuthException catch (e) {
      error = e.message;
      return false;
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  /// JWT ka `exp` claim check (backend 1 din ka token deta hai).
  bool _isExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;
      final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload is Map ? payload['exp'] : null;
      if (exp is int) {
        return DateTime.fromMillisecondsSinceEpoch(exp * 1000).isBefore(DateTime.now());
      }
    } catch (_) {}
    return false;
  }
}