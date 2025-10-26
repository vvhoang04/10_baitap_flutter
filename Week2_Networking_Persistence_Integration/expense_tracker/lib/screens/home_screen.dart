// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'expense_list_tab.dart'; // Tab 1
import 'expense_chart_tab.dart'; // Tab 2
import 'add_expense_screen.dart'; // Màn hình thêm

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Tab hiện tại

  final List<Widget> _tabs = [
    ExpenseListTab(), // Tab 0: Danh sách
    ExpenseChartTab(),  // Tab 1: Biểu đồ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expense Tracker'),
      ),
      body: _tabs[_currentIndex], // Hiển thị tab được chọn

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Điều hướng đến màn hình thêm chi tiêu
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Thanh điều hướng dưới cùng
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Tạo "khuyết" cho FAB
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.list, color: _currentIndex == 0 ? Colors.green : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.pie_chart, color: _currentIndex == 1 ? Colors.green : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
          ],
        ),
      ),
    );
  }
}