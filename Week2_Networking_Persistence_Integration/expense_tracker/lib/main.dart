// lib/main.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/expense_model.dart';
import 'screens/home_screen.dart'; // Màn hình chính ta sẽ tạo

// Tên của Hive Box (giống như tên 1 bảng)
const String expenseBoxName = 'expenses';

void main() async {
  // 1. Đảm bảo Flutter đã sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Lấy thư mục ứng dụng
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  // 3. Khởi tạo Hive
  await Hive.initFlutter(appDocumentDir.path);

  // 4. Đăng ký Adapter (đã được sinh ra ở Bước 2)
  Hive.registerAdapter(ExpenseAdapter());

  // 5. Mở Box (để chúng ta có thể dùng nó sau này)
  await Hive.openBox<Expense>(expenseBoxName);

  // 6. Chạy ứng dụng
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(), // Màn hình chính
    );
  }
}