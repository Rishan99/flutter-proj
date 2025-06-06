import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignupModel {
  final String email;
  final String name;
  final String password;
  SignupModel({
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
    };
  }
}
