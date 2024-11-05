// File: auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Store the login token
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_token', token);
  }

  // Retrieve the login token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_token');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null; // True if the token is not null
  }

  // Clear the token (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_token');
  }
}
