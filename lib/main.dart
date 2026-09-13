import 'package:flutter/material.dart';
import 'user_registration_form.dart';

// NIM: 2411533018

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration Form',
      home: const UserRegistrationForm(),
    );
  }
}