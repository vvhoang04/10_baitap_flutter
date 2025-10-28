# Project 9: Ứng dụng Nhắc nhở (Local Notifications)

Đây là một project có độ phức tạp kỹ thuật cao, tập trung vào việc tích hợp tính năng **thông báo cục bộ (Local Notifications)**. Ứng dụng cho phép người dùng đặt lời nhắc (với tiêu đề và thời gian cụ thể), và hệ điều hành sẽ kích hoạt thông báo vào đúng thời điểm đó, **ngay cả khi ứng dụng đã bị đóng**.

## 🎯 Mục tiêu học tập

-   Sử dụng thư viện **`flutter_local_notifications`** để quản lý, tạo và lên lịch thông báo.
-   Hiểu và thực hiện các bước **cấu hình native (gốc)** phức tạp, bao gồm:
    -   Chỉnh sửa `build.gradle` / `build.gradle.kts` (Android) để đặt `compileSdk`.
    -   Thêm các quyền (Permissions) và `Receiver` vào `AndroidManifest.xml` (Android).
    -   Thêm code yêu cầu quyền vào `AppDelegate.swift` (iOS).
-   Học cách yêu cầu các quyền đặc biệt mới trên Android, như `POST_NOTIFICATIONS` (Android 13+) và `SCHEDULE_EXACT_ALARM` (Android 12+).
-   Sử dụng `DateTimePicker` để lấy dữ liệu ngày và giờ từ người dùng.
-   Sử dụng thư viện **`timezone`** để đảm bảo thông báo được lên lịch chính xác theo múi giờ của thiết bị, tránh lỗi sai lệch thời gian.
-   Tạo một `NotificationService` (Singleton) để đóng gói và quản lý tất cả logic liên quan đến thông báo.

## 🖼️ Ảnh chụp màn hình

| Giao diện chính |
| :---: |
| ![image alt](https://github.com/vvhoang04/10_baitap_flutter/blob/3211ab42424043ca02819ed4be531da338e13996/Week2_Networking_Persistence_Integration/reminder_app/img_remider.png) |
 
## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **Gói thư viện (Plugins):**
    -   `flutter_local_notifications`: Plugin chính để xử lý thông báo.
    -   `flutter_datetime_picker_plus`: Để chọn ngày/giờ.
    -   `timezone`: Để khởi tạo và xử lý múi giờ (`tz.zonedSchedule`).
    -   `intl`: Để định dạng ngày giờ hiển thị trên UI.
-   **Kiến trúc:** Singleton Pattern cho `NotificationService`.
-   **Xử lý bất đồng bộ:** `async` / `await` để khởi tạo service và lên lịch.

## 🚀 Cài đặt & Chạy dự án (CỰC KỲ QUAN TRỌNG)

Project này sẽ **KHÔNG CHẠY** nếu bạn không hoàn thành các bước cấu hình native dưới đây.

### 1. Cài đặt Thư viện
Đảm bảo `pubspec.yaml` của bạn có đủ các thư viện:
```yaml
dependencies:
  flutter_local_notifications: ^17.2.1
  flutter_datetime_picker_plus: ^2.1.0
  timezone: ^0.9.4
  intl: ^0.19.0
