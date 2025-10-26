// lib/models/expense_model.dart

import 'package:hive/hive.dart';

// 1. Thêm dòng "part" này. Tên file phải là <tên_file>.g.dart
part 'expense_model.g.dart';

// 2. Thêm @HiveType() và typeId (phải là duy nhất)
@HiveType(typeId: 0)
class Expense {
  // 3. Thêm @HiveField() cho mỗi trường
  //    Các "index" (0, 1, 2) phải là duy nhất
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
  });
}