// lib/auth_gate.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_screen.dart'; // Màn hình chính
import 'screens/login_or_register_screen.dart'; // Màn hình đăng nhập

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // (Yêu cầu) Dùng StreamBuilder để lắng nghe thay đổi trạng thái Auth
      body: StreamBuilder<User?>(
        //FirebaseAuth.instance.authStateChanges() là luồng (Stream)
        //nó sẽ tự động phát ra "User" nếu đăng nhập, hoặc "null" nếu đăng xuất.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // 1. Trạng thái Đang chờ (Connecting...)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // 2. Trạng thái Lỗi (ít khi xảy ra)
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          // 3. Trạng thái Thành công (Connected)
          // 3.1. Nếu snapshot CÓ DỮ LIỆU (User != null) -> Đã đăng nhập
          if (snapshot.hasData) {
            return HomeScreen(); // Đi tới Trang chủ
          }
          // 3.2. Nếu snapshot KHÔNG CÓ DỮ LIỆU (User == null) -> Chưa đăng nhập
          else {
            return LoginOrRegisterScreen(); // Đi tới Trang Đăng nhập
          }
        },
      ),
    );
  }
}