// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onTap; // Hàm callback để chuyển sang Register
  LoginScreen({required this.onTap});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Hàm xử lý Đăng nhập
  Future<void> _signIn() async {
    // Hiển thị vòng xoay "loading"
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // (Yêu cầu) Dùng firebase_auth để đăng nhập
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Tắt vòng xoay "loading" nếu thành công
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // Tắt vòng xoay "loading"
      Navigator.of(context).pop();
      // Hiển thị lỗi
      _showErrorDialog(e.message ?? 'Login failed');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome Back!', style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Nút rộng
                ),
                onPressed: _signIn,
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: widget.onTap, // Gọi hàm callback để chuyển màn hình
                child: Text('Not a member? Register now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}