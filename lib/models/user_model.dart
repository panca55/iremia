import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  final String? userId;
  final String? email;
  final String? password;
  final String? name;
  final String? usia;
  final String? jenisKelamin;
  final DateTime? dateCreated;
  bool isHide = true;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.password,
    this.jenisKelamin,
    this.usia,
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
      'dateCreated': dateCreated,
    };
  }

  /// **Metode untuk mengganti password tersembunyi**
  void isHidePassword() {
    isHide = !isHide;
    debugPrint('is Hide Password? $isHide');
    notifyListeners();
  }

  /// **Tambahkan metode `copyWith`**
  UserModel copyWith({
    String? userId,
    String? email,
    String? password,
    String? name,
    String? usia,
    String? jenisKelamin,
    DateTime? dateCreated,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      usia: usia ?? this.usia,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}
