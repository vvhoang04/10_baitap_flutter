// lib/notification_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // Singleton pattern (để chỉ có 1 instance của service)
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 1. Hàm khởi tạo (Init)
  Future<void> init() async {
    // 1.1. Cài đặt cho Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher', // Icon app (lấy từ thư mục android/app/src.../res/mipmap)
    );

    // 1.2. Cài đặt cho iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: _onDidReceiveLocalNotification, // (Nâng cao)
    );

    // 1.3. Khởi tạo plugin
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      // onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse, // (Nâng cao)
    );

    // 1.4. (Rất quan trọng) Khởi tạo Timezone
    tz.initializeTimeZones();
    // Đặt múi giờ địa phương
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh')); // Hoặc múi giờ của bạn
  }

  // 2. Hàm Yêu cầu Quyền (cho Android 13+)
  Future<void> requestPermissions() async {
    // Cho Android 13 (API 33)
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // Yêu cầu quyền POST_NOTIFICATIONS
    await androidPlugin?.requestNotificationsPermission();

    // Yêu cầu quyền lên lịch chính xác (Android 12+)
    await androidPlugin?.requestExactAlarmsPermission();
  }


  // 3. (Yêu cầu) Hàm Lên lịch Thông báo
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {

    // 3.1. Tạo chi tiết thông báo
    const NotificationDetails details = NotificationDetails(
      // Cài đặt cho Android
      android: AndroidNotificationDetails(
        'reminder_channel_id', // ID của Channel
        'Reminders',           // Tên Channel
        channelDescription: 'Channel for reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
      ),
      // Cài đặt cho iOS
      iOS: DarwinNotificationDetails(
        sound: 'default.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    // 3.2. Lên lịch (dùng zonedSchedule)
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local), // Chuyển DateTime sang TZDateTime
      details,
      // Điều này rất quan trọng để khớp thời gian
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // 4. (Tùy chọn) Hàm Hủy thông báo
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}