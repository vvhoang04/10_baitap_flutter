// lib/screens/add_expense_screen.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/expense_model.dart';
import '../main.dart'; // Để lấy tên box

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  // Hàm hiển thị DatePicker
  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Hàm xử lý lưu
  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final amount = double.tryParse(_amountController.text);

      if (amount == null || amount <= 0) {
        // Hiển thị lỗi nếu số tiền không hợp lệ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid amount.')),
        );
        return;
      }

      // 1. Tạo đối tượng Expense mới
      final newExpense = Expense(
        title: title,
        amount: amount,
        date: _selectedDate,
      );

      // 2. (Yêu cầu) Lưu vào Hive Box
      final box = Hive.box<Expense>(expenseBoxName);
      box.add(newExpense); // Chỉ cần .add() là xong!

      // 3. Quay về màn hình trước
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter an amount' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    child: Text('Choose Date'),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Expense'),
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}