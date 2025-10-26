// lib/screens/login_or_register_screen.dart

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  @override
  _LoginOrRegisterScreenState createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  // Ban đầu, hiển thị màn hình Đăng nhập
  bool _showLoginScreen = true;

  // Hàm để chuyển đổi
  void _toggleScreens() {
    setState(() {
      _showLoginScreen = !_showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginScreen) {
      // Truyền hàm _toggleScreens xuống cho LoginScreen
      return LoginScreen(onTap: _toggleScreens);
    } else {
      // Truyền hàm _toggleScreens xuống cho RegisterScreen
      return RegisterScreen(onTap: _toggleScreens);
    }
  }
}