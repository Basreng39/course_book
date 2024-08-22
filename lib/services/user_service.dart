import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  // static const String baseUrl = 'http://127.0.0.1:8000/api/auth/login';
  static const String baseUrl = 'http://192.168.100.151:8000/api/auth/login';

  Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final User user = User.fromJson(jsonResponse);

        // Save user data to SharedPreferences
        await _saveUserToPreferences(user);
      } else if (response.statusCode == 401) {
        throw Exception('Email or password is incorrect');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> _saveUserToPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('userName', user.name);
    await prefs.setString('alamat', user.address ?? '');
    await prefs.setString('no_hp', user.phoneNumber ?? '');
    await prefs.setString('userProfileImageUrl', user.image ?? '');
    await prefs.setString('status', user.status ?? '');

    // Log to ensure the URL is saved correctly
    print('User profile image URL saved: ${user.image}');
    print('User saved to SharedPreferences: ${user.id}');
  }

  Future<User?> getUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('id')) {
      final profileImageUrl = prefs.getString('userProfileImageUrl')!;
      // Log to verify the retrieved image URL
      print('Profile Image URL from SharedPreferences: $profileImageUrl');

      return User(
        id: prefs.getInt('id')!,
        email: prefs.getString('email')!,
        name: prefs.getString('userName')!,
        address: prefs.getString('alamat')!,
        phoneNumber: prefs.getString('no_hp')!,
        image: profileImageUrl,
        status: prefs.getString('status')!,
      );
    } else {
      return null;
    }
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
