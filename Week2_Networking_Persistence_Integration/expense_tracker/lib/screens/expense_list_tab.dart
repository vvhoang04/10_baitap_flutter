// lib/screens/expense_list_tab.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/expense_model.dart';
import '../main.dart'; // Để lấy tên box

class ExpenseListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Lấy Box
    final box = Hive.box<Expense>(expenseBoxName);

    // Định dạng tiền tệ
    final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    // 2. Dùng ValueListenableBuilder để tự động cập nhật UI
    //    khi Hive Box có thay đổi (thêm/xóa)
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<Expense> box, _) {
        // Lấy tất cả chi tiêu và sắp xếp (mới nhất lên đầu)
        var expenses = box.values.toList().cast<Expense>();
        expenses.sort((a, b) => b.date.compareTo(a.date));

        if (expenses.isEmpty) {
          return Center(
            child: Text('No expenses yet. Add one!'),
          );
        }

        // 3. Hiển thị ListView
        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(expense.title, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(DateFormat.yMMMd().format(expense.date)),
                trailing: Text(
                  currencyFormatter.format(expense.amount),
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // (Bonus) Nhấn giữ để xóa
                onLongPress: () {
                  box.deleteAt(index); // Xóa khỏi Hive
                },
              ),
            );
          },
        );
      },
    );
  }
}