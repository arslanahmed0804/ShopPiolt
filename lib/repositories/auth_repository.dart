// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../config/api_config.dart';
// import '../models/auth_user.dart';

// /// Screen ko dikhane layak message ke saath error.
// class AuthException implements Exception {
//   final String message;
//   const AuthException(this.message);
//   @override
//   String toString() => message;
// }

// abstract class AuthRepository {
//   /// POST /auth/login  ->  { success, message, token, user }
//   Future<AuthSession> login(String email, String password);

//   /// POST /auth/register  ->  { success, message, user }   (token nahi deta)
//   Future<AuthUser> register(String name, String email, String password);
// }

// class ApiAuthRepository implements AuthRepository {
//   final http.Client _client;
//   final String _base;

//   ApiAuthRepository({http.Client? client, String? baseUrl})
//       : _client = client ?? http.Client(),
//         _base = '${baseUrl ?? ApiConfig.baseUrl}${ApiConfig.authPath}';

//   @override
//   Future<AuthSession> login(String email, String password) async {
//     final data = await _post('/login', {'email': email, 'password': password});
//     final token = data['token'];
//     final user = data['user'];
//     if (token is! String || user is! Map<String, dynamic>) {
//       throw const AuthException('Unexpected response from server');
//     }
//     return AuthSession(token: token, user: AuthUser.fromJson(user));
//   }

//   @override
//   Future<AuthUser> register(String name, String email, String password) async {
//     final data = await _post('/register', {'name': name, 'email': email, 'password': password});
//     final user = data['user'];
//     if (user is! Map<String, dynamic>) {
//       throw const AuthException('Unexpected response from server');
//     }
//     return AuthUser.fromJson(user);
//   }

//   Future<Map<String, dynamic>> _post(String path, Map<String, dynamic> body) async {
//     try {
//       final res = await _client
//           .post(
//             Uri.parse('$_base$path'),
//             headers: const {'Content-Type': 'application/json'},
//             body: jsonEncode(body),
//           )
//           .timeout(ApiConfig.timeout);

//       final decoded = res.body.isEmpty ? <String, dynamic>{} : jsonDecode(res.body);
//       final data = decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};

//       final ok = res.statusCode >= 200 && res.statusCode < 300 && data['success'] != false;
//       if (ok) return data;

//       // Backend ka message ({success:false, message}) seedha user ko dikhao
//       throw AuthException(data['message']?.toString() ?? 'Something went wrong (${res.statusCode})');
//     } on AuthException {
//       rethrow;
//     } on TimeoutException {
//       throw const AuthException('Server is not responding. Please try again.');
//     } on FormatException {
//       throw const AuthException('Unexpected response from server');
//     } catch (_) {
//       throw const AuthException('Could not reach the server. Check your connection and server URL.');
//     }
//   }
// }import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'config/api_config.dart';
import '../config//api_config.dart';
import '../models/auth_user.dart';

/// Screen ko dikhane layak message ke saath error.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  @override
  String toString() => message;
}

abstract class AuthRepository {
  /// POST /auth/login  ->  { success, message, token, user }
  Future<AuthSession> login(String email, String password);

  /// POST /auth/register  ->  { success, message, user }   (token nahi deta)
  Future<AuthUser> register(String name, String email, String password);
}

class ApiAuthRepository implements AuthRepository {
  final http.Client _client;
  final String _base;

  ApiAuthRepository({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _base = '${baseUrl ?? ApiConfig.baseUrl}${ApiConfig.authPath}';

  @override
  Future<AuthSession> login(String email, String password) async {
    final data = await _post('/login', {'email': email, 'password': password});
    final token = data['token'];
    final user = data['user'];
    if (token is! String || user is! Map<String, dynamic>) {
      throw const AuthException('Unexpected response from server');
    }
    return AuthSession(token: token, user: AuthUser.fromJson(user));
  }

  @override
  Future<AuthUser> register(String name, String email, String password) async {
    final data = await _post('/register', {
      'name': name,
      'email': email,
      'password': password,
    });
    final user = data['user'];
    if (user is! Map<String, dynamic>) {
      throw const AuthException('Unexpected response from server');
    }
    return AuthUser.fromJson(user);
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final res = await _client
          .post(
            Uri.parse('$_base$path'),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.timeout);

      final decoded = res.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(res.body);
      final data = decoded is Map<String, dynamic>
          ? decoded
          : <String, dynamic>{};

      final ok =
          res.statusCode >= 200 &&
          res.statusCode < 300 &&
          data['success'] != false;
      if (ok) return data;

      // Backend ka message ({success:false, message}) seedha user ko dikhao
      throw AuthException(
        data['message']?.toString() ??
            'Something went wrong (${res.statusCode})',
      );
    } on AuthException {
      rethrow;
    } on TimeoutException {
      throw const AuthException('Server is not responding. Please try again.');
    } on FormatException {
      throw const AuthException('Unexpected response from server');
    } catch (e) {
      debugPrint('Auth request failed: $e');
      // Debug mein asli URL + error dikhao taake masla samajh aaye
      throw AuthException(
        kDebugMode
            ? 'Could not reach $_base$path\n$e'
            : 'Could not reach the server. Check your connection and server URL.',
      );
    }
  }
}
