import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/user_model.dart';

class FirebaseService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print('Notification tapped: ${details.payload}');
      },
    );

    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });
  }

  static Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc['role'];
      }
      return null;
    } catch (e) {
      print("Error fetching role: $e");
      return null;
    }
  }

  static Future<UserCredential?> signInWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  static Future<String> uploadProfileImage(File imageFile) async {
    try {
      final String fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = FirebaseStorage.instance.ref();
      final Reference profileImageRef =
          storageRef.child('profile_images').child(fileName);

      // Create upload task
      final UploadTask uploadTask = profileImageRef.putFile(
          imageFile,
          SettableMetadata(
              contentType: 'image/jpeg',
              customMetadata: {'picked-file-path': imageFile.path}));

      // Wait for the upload to complete and get the download URL
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image path: ${imageFile.path}');
      print('Exists: ${await imageFile.exists()}');

      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      print('Image path: ${imageFile.path}');
      print('Exists: ${await imageFile.exists()}');
      throw Exception('Failed to upload profile image. Please try again.');
    }
  }

  static Future<void> registerUser(UserModel user, String password) async {
    try {
      // Create user authentication
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // Convert DateTime objects to Timestamps for Firestore
      final userData = {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'mobile': user.mobile,
        'birthday': Timestamp.fromDate(user.dob),
        'join_date': Timestamp.fromDate(user.joinDate),
        'designation_date': Timestamp.fromDate(user.designationDate),
        'role': user.role,
        'supervisor_id': user.supervisorId,
        'profile_image_url': user.profileImageUrl,
        'emergency_contact': user.emergencyContact,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      };

      // Store user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userData);
    } catch (e) {
      print("Error registering user: $e");
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            throw Exception(
                'This email is already registered. Please use a different email.');
          case 'weak-password':
            throw Exception(
                'The password provided is too weak. Please use a stronger password.');
          default:
            throw Exception('Failed to register user: ${e.message}');
        }
      }
      throw Exception('Failed to register user. Please try again.');
    }
  }
}
