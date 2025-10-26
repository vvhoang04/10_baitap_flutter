// lib/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDateTime; // State để lưu ngày giờ đã chọn

  // (Yêu cầu) Hàm mở DateTimerPicker
  void _pickDateTime() {
    picker.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(), // Không cho chọn quá khứ
      maxTime: DateTime.now().add(Duration(days: 365)), // Giới hạn 1 năm
      onConfirm: (date) {
        // Khi người dùng nhấn "Confirm"
        setState(() {
          _selectedDateTime = date;
        });
      },
      currentTime: DateTime.now(),
      locale: picker.LocaleType.vi, // (Tùy chọn) Dùng tiếng Việt
    );
  }

  // Hàm xử lý Lên lịch
  void _scheduleReminder() {
    final String title = _titleController.text;

    // 1. Kiểm tra
    if (title.isEmpty) {
      _showErrorDialog('Title cannot be empty.');
      return;
    }
    if (_selectedDateTime == null) {
      _showErrorDialog('Please select a date and time.');
      return;
    }
    if (_selectedDateTime!.isBefore(DateTime.now())) {
      _showErrorDialog('Cannot schedule a reminder in the past.');
      return;
    }

    // 2. (Yêu cầu) Gọi service để lên lịch
    // Tạo ID ngẫu nhiên (hoặc dùng timestamp)
    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    NotificationService().scheduleNotification(
      id: id,
      title: 'Reminder!',
      body: title,
      scheduledTime: _selectedDateTime!,
    );

    // 3. Xóa state và thông báo thành công
    setState(() {
      _titleController.clear();
      _selectedDateTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder scheduled successfully!')),
    );
  }

  // Hiển thị dialog lỗi
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
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule a Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. (Yêu cầu) TextField cho Title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'What to remind you about?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // 2. (Yêu cầu) DateTimePicker (hiển thị)
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime == null
                        ? 'No time selected'
                        : 'Time: ${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDateTime!)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  child: Text('Pick Time'),
                  onPressed: _pickDateTime,
                ),
              ],
            ),
            SizedBox(height: 30),

            // 3. Nút Lên lịch
            ElevatedButton.icon(
              icon: Icon(Icons.notifications_active),
              label: Text('Schedule Reminder'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _scheduleReminder,
            ),
          ],
        ),
      ),
    );
  }
}