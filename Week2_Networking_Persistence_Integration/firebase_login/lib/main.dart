// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File này được tự động tạo
import 'auth_gate.dart'; // Màn hình "cổng" chúng ta sắp tạo

void main() async {
  // 1. Đảm bảo Flutter sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Khởi tạo Firebase (Rất quan trọng)
  // Dùng DefaultFirebaseOptions.currentPlatform từ file firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // 3. Chạy App
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // AuthGate sẽ quyết định màn hình nào được hiển thị
      home: AuthGate(),
    );
  }
}