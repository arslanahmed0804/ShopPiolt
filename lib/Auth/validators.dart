/// Backend ke rules ke mutabiq (name, email, password >= 8 chars).
class Validators {
  static String? name(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Please enter your name' : null;

  static String? email(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Please enter your email';
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s) ? null : 'Enter a valid email';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your password';
    return v.length < 8 ? 'Password must be at least 8 characters' : null;
  }

  /// Login par sirf "khali na ho" check - length rule purane accounts ko block na kare
  static String? passwordRequired(String? v) =>
      (v == null || v.isEmpty) ? 'Please enter your password' : null;
}