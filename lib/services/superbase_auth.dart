import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:exfactor/models/user_model.dart';
import 'package:exfactor/services/superbase_service.dart';
import 'dart:io';

class SuperbaseAuth {
  static final SupabaseClient _client = Supabase.instance.client;

  /// Registers a new user: creates auth user, uploads image, then inserts user data in user table.
  /// Returns a map with 'success': bool, 'message': String, and 'userId': String?
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
    required UserModel userModel,
    required File profileImageFile,
  }) async {
    try {
      // 1. Sign up with Supabase Auth
      final authResponse = await _client.auth.signUp(
        email: email,
        password: password,
      );
      final user = authResponse.user;
      if (user == null) {
        return {
          'success': false,
          'message': 'Auth registration failed.',
          'userId': null
        };
      }
      final String userId = user.id;

      // 2. Upload profile image and get storage path
      final String fileName =
          'profileimages/${userId}_${DateTime.now().millisecondsSinceEpoch}.png';
      await _client.storage.from('profileimages').upload(
            fileName,
            profileImageFile,
            fileOptions: const FileOptions(contentType: 'image/png'),
          );
      // Only save the storage path, not the public URL
      final String profileImagePath = fileName;

      // 3. Insert user data into user table
      final userData = userModel
          .copyWith(
            userId: userId,
            profileImage: profileImagePath,
          )
          .toMap();
      await SupabaseService.insertUserMetaData(userData);

      return {
        'success': true,
        'message': 'User registered successfully.',
        'userId': userId
      };
    } catch (e) {
      return {'success': false, 'message': e.toString(), 'userId': null};
    }
  }
}
