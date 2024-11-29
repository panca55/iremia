import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  final String? userId;
  final String? email;
  final String? password;
  final String? name;
  final String? usia;
  final String? jenisKelamin;
  final String? role;
  final DateTime? dateCreated;
  bool isHide = true;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.password,
    this.usia,
    this.jenisKelamin,
    this.role,
    this.dateCreated,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      email: data['email'],
      password: data['password'],
      name: data['name'],
      usia: data['age'],
      jenisKelamin: data['gender'],
      role: data['role'],
      dateCreated: (data['dateCreated']).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      'password': password,
      'name': name,
      'age': usia,
      'gender': jenisKelamin,
      'role': role,
      'dateCreated': dateCreated,
    };
  }

  /// **Metode untuk mengganti password tersembunyi**
  void isHidePassword() {
    isHide = !isHide;
    debugPrint('is Hide Password? $isHide');
    notifyListeners();
  }

  UserModel copyWith({
    String? userId,
    String? email,
    String? password,
    String? name,
    String? usia,
    String? jenisKelamin,
    String? role,
    DateTime? dateCreated,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      usia: usia ?? this.usia,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      role: role ?? this.role,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}
