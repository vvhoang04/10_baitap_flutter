// lib/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onTap; // Hàm callback để chuyển về Login
  RegisterScreen({required this.onTap});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Hàm xử lý Đăng ký
  Future<void> _signUp() async {
    // Kiểm tra mật khẩu
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      _showErrorDialog("Passwords don't match!");
      return;
    }

    // Hiển thị vòng xoay "loading"
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // (Yêu cầu) Dùng firebase_auth để tạo user mới
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Tắt vòng xoay "loading"
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // Tắt vòng xoay "loading"
      Navigator.of(context).pop();
      // Hiển thị lỗi
      _showErrorDialog(e.message ?? 'Registration failed');
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
              Text('Create Account', style: Theme.of(context).textTheme.headlineMedium),
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
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: widget.onTap, // Gọi hàm callback để chuyển màn hình
                child: Text('Already a member? Login now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}