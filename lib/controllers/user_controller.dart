import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iremia/models/user_model.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class UserController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  final _key = encrypt.Key.fromLength(32); // Kunci enkripsi 256-bit

  /// **Enkripsi Password dengan IV Unik**
  Map<String, String> encryptPassword(String password) {
    final iv = encrypt.IV.fromSecureRandom(16); // IV unik setiap kali
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));

    // Enkripsi password
    final encrypted = encrypter.encrypt(password, iv: iv);

    return {
      'encryptedPassword': encrypted.base64, // Data terenkripsi
      'iv': iv.base64, // Simpan IV dalam Base64
    };
  }

  /// **Dekripsi Password**
  String decryptPassword(String encryptedPassword, String ivBase64) {
    final iv = encrypt.IV.fromBase64(ivBase64); // Dekode IV dari Base64
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));

    // Dekripsi password
    return encrypter.decrypt64(encryptedPassword, iv: iv);
  }

  /// **REGISTER USER**
  Future<bool> registerUser(UserModel userModel) async {
    try {
      // Register di Firebase Authentication menggunakan password plain-text
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel
            .password!, // Firebase Authentication memerlukan plain-text
      );

      // Enkripsi password sebelum menyimpannya di Firestore
      final encryptedData = encryptPassword(userModel.password!);

      // Simpan data user ke Firestore
      final userId = userCredential.user?.uid;
      await _firestore.collection('users').doc(userId).set({
        'name': userModel.name,
        'email': userModel.email,
        'gender': userModel.jenisKelamin,
        'age': userModel.usia,
        'password': encryptedData['encryptedPassword'], // Terenkripsi
        'iv': encryptedData['iv'], // Simpan IV
        'dateCreated': FieldValue.serverTimestamp(),
        'userId': userId,
      });

      // Update user lokal
      _currentUser =
          userModel.copyWith(userId: userId, dateCreated: DateTime.now());
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error registering user: $e');
      return false;
    }
  }


  /// **LOGIN USER**
  Future<bool> loginUser(String email, String password) async {
    try {
      // Login menggunakan Firebase Authentication dengan password plain-text
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ambil data user dari Firestore berdasarkan userId
      final userId = userCredential.user?.uid;
      final snapshot = await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        final userData = snapshot.data()!;

        // Simpan data user ke dalam _currentUser
        _currentUser = UserModel.fromFirestore(userData);
        notifyListeners();

        return true;
      } else {
        debugPrint('User not found in Firestore');
        return false;
      }
    } catch (e) {
      debugPrint('Error logging in: $e');
      return false;
    }
  }


  /// **LOGOUT USER**
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error logging out: $e');
    }
  }

  /// **EDIT USER PROFILE**
  Future<bool> editUserProfile({
    required String userId,
    String? name,
    String? email,
    String? password,
    String? gender,
    String? age,
  }) async {
    try {
      // Pastikan userId tidak kosong
      if (userId.isEmpty) {
        throw Exception('User ID is required.');
      }
      // Update data di Firestore
      final Map<String, dynamic> updatedData = {};
      if (name != null) updatedData['name'] = name;
      if (email != null) updatedData['email'] = email;
      if (password != null) updatedData['password'] = password;
      if (gender != null) updatedData['gender'] = gender;
      if (age != null) updatedData['age'] = age;

      if (updatedData.isNotEmpty) {
        await _firestore.collection('users').doc(userId).update(updatedData);
      }

      // Update _currentUser di lokal jika ada perubahan
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(
          name: name ?? _currentUser!.name,
          email: email ?? _currentUser!.email,
          password: password ?? _currentUser!.password,
          jenisKelamin: gender ?? _currentUser!.jenisKelamin,
          usia: age ?? _currentUser!.usia,
        );
        notifyListeners();
      }

      return true;
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      return false;
    }
  }
}
