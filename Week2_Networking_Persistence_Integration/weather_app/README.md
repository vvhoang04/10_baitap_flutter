# Project 6: Ứng dụng Thời tiết (Networking & Geolocation)

tập trung vào việc lấy dữ liệu từ bên ngoài (Internet và cảm biến của thiết bị). Ứng dụng sẽ tự động lấy vị trí hiện tại của người dùng, sau đó gọi một API thời tiết (OpenWeatherMap) để hiển thị thông tin thời tiết trực tiếp.

## 🎯 Mục tiêu học tập

-   Học cách xử lý các tác vụ bất đồng bộ (asynchronous) bằng `async` / `await`.
-   Sử dụng `FutureBuilder` để quản lý vòng đời của một `Future` và hiển thị các trạng thái UI khác nhau (Loading, Error, Success).
-   Sử dụng thư viện `geolocator` để lấy quyền truy cập vị trí (Permission) và lấy tọa độ GPS (Latitude, Longitude) của thiết bị.
-   Sử dụng thư viện `http` để thực hiện một cuộc gọi REST API (GET request) đến một máy chủ bên ngoài.
-   Hiểu cách phân tích (parse) dữ liệu **JSON** phức tạp trả về từ API thành một `class` Model (ví dụ: `Weather`) trong Dart.
-   Xử lý lỗi (Error Handling) khi gọi API hoặc khi người dùng từ chối cấp quyền.
-   Cấu hình quyền (Permissions) cho cả Android (`AndroidManifest.xml`) và iOS (`Info.plist`).

## 🖼️ Ảnh chụp màn hình

| Giao diện chính |
| :---: |
| ![iamge alt](https://github.com/vvhoang04/10_baitap_flutter/blob/ee94018b9c3726c9063695116e67317096a13d16/Week2_Networking_Persistence_Integration/weather_app/img_weather.png) |

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **Bất đồng bộ:** `FutureBuilder`, `async`/`await`
-   **Gói thư viện (Networking & Device):**
    -   `geolocator`: Lấy vị trí GPS.
    -   `http`: Gọi API thời tiết.
    -   `intl`: (Tùy chọn) Để định dạng ngày giờ (ví dụ: giờ mặt trời mọc/lặn).
-   **Xử lý dữ liệu:** `dart:convert` (để `jsonDecode`), Factory constructor (`Weather.fromJson`) để parse JSON.
-   **Xử lý Lỗi/Tải:** `CircularProgressIndicator` (cho trạng thái loading), `Text` (cho trạng thái `snapshot.hasError`).

## 🚀 Cài đặt & Chạy dự án

Dự án này yêu cầu **API Key** từ OpenWeatherMap và **Cấu hình Quyền**.

### 1. Cài đặt API Key
1.  Truy cập [https://openweathermap.org/](https://openweathermap.org/) và đăng ký một tài khoản miễn phí.
2.  Vào mục "My API keys" và copy API Key của bạn.
3.  Mở file `lib/weather_service.dart`.
4.  Dán API Key của bạn vào biến `_apiKey`:
    ```dart
    static const String _apiKey = "YOUR_API_KEY_HERE";
    ```

### 2. Cấu hình Quyền (Permissions)
Bạn *bắt buộc* phải thêm quyền truy cập vị trí:

-   **Android:** Mở `android/app/src/main/AndroidManifest.xml` và thêm 2 dòng này vào trong thẻ `<manifest>`:
    ```xml
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    ```
-   **iOS:** Mở `ios/Runner/Info.plist` và thêm các cặp key/string này vào trong thẻ `<dict>`:
    ```xml
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>Cần truy cập vị trí để lấy dự báo thời tiết.</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>Cần truy cập vị trí để lấy dự báo thời tiết.</string>
    ```

### 3. Chạy ứng dụng
1.  Lấy các gói phụ thuộc:
    ```bash
    flutter pub add geolocator http intl
    flutter pub get
    ```
2.  Chạy ứng dụng:
    ```bash
    flutter run
    ```
    *(Ứng dụng sẽ hỏi xin quyền vị trí khi khởi động lần đầu. Bạn phải "Cho phép" để ứng dụng hoạt động.)*
