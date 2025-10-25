import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  static const _kUsersKey = 'auth_users'; // email -> password (demo)
  static const _kCurrentKey = 'auth_current_email';

  String? _currentEmail;

  String? get currentUserEmail => _currentEmail;

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<bool> register(String email, String password) async {
    final p = await _prefs;
    final dbJson = p.getString(_kUsersKey);
    final Map<String, String> db =
        dbJson == null ? {} : Map<String, String>.from(jsonDecode(dbJson));

    if (db.containsKey(email)) return false; // already exists

    // ⚠️ Demo only — production-д plaintext хадгалахгүй!
    db[email] = password;
    await p.setString(_kUsersKey, jsonEncode(db));
    return true;
  }

  Future<bool> login(String email, String password) async {
    final p = await _prefs;
    final dbJson = p.getString(_kUsersKey);
    final Map<String, String> db =
        dbJson == null ? {} : Map<String, String>.from(jsonDecode(dbJson));

    if (db[email] == password) {
      _currentEmail = email;
      await p.setString(_kCurrentKey, email);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final p = await _prefs;
    _currentEmail = null;
    await p.remove(_kCurrentKey);
  }

  Future<void> hydrate() async {
    final p = await _prefs;
    _currentEmail = p.getString(_kCurrentKey);
  }
}
