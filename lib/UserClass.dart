import 'package:flutter/material.dart';

class UserClass {
  late String first_name;
  late String last_name;
  late String email;
  late String password;

  UserClass (this.first_name, this.last_name, this.email, this.password);
  factory UserClass.fromJson (dynamic json) {
    return UserClass(json['first_name'] as String, json['last_name'] as String, json['email'] as String, json['password'] as String);
  }

  Map toJson () => {
    'first_name': first_name,
    'last_name': last_name,
    'email': email,
    'password': password,
  };
}