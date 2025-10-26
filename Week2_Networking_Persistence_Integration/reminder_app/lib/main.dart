// lib/main.dart

import 'package:flutter/material.dart';
import 'notification_service.dart'; // Import service
import 'home_screen.dart'; // Màn hình chính ta sẽ tạo

void main() async {
  // 1. Đảm bảo Flutter sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Khởi tạo Notification Service
  await NotificationService().init();
  
  // 3. Yêu cầu quyền (Android 13+)
  await NotificationService().requestPermissions();

  // 3. Chạy app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(), // Màn hình chính
    );
  }
}