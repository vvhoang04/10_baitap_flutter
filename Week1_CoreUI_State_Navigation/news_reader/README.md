# Project 3: Ứng dụng Đọc tin tức (News Reader App)

Đây là project thứ ba, tập trung vào một trong những kỹ năng quan trọng nhất của lập trình di động: **làm việc với dữ liệu trực tuyến từ REST API**.

Ứng dụng này sẽ gọi đến API của [NewsAPI.org](https://newsapi.org/), lấy danh sách các bài báo hàng đầu (top headlines) tại Mỹ, và hiển thị chúng trong một giao diện người dùng sạch sẽ, hiện đại.

## 🎯 Mục tiêu học tập

Mục tiêu chính của dự án này là học cách xử lý lập trình bất đồng bộ (asynchronous) trong Flutter.

-   Hiểu cách thực hiện một HTTP request (gọi API) bằng thư viện `http`.
-   Làm quen với `Future`, `async`, và `await` để xử lý các tác vụ tốn thời gian mà không làm "đóng băng" ứng dụng.
-   Sử dụng `FutureBuilder`—một widget cực kỳ mạnh mẽ để tự động hiển thị UI dựa trên trạng thái của một `Future` (Đang tải, Bị lỗi, hoặc Hoàn thành).
-   Triển khai **Loading Indicators** (`CircularProgressIndicator`) và **Error Handling** (hiển thị thông báo lỗi) một cách thân thiện.
-   Parse dữ liệu **JSON** (định dạng dữ liệu phổ biến nhất trên web) thành một `class` Model (ví dụ: `Article`) để dễ dàng quản lý và sử dụng.
-   Tách biệt logic gọi API ra khỏi UI (vào một `NewsService` class) để code sạch sẽ và dễ bảo trì.
-   Sử dụng các thư viện bên ngoài (plugins) như `url_launcher` để mở link bài báo và `timeago` để định dạng ngày tháng.

## 🖼️ Ảnh chụp màn hình

| Giao diện chính | Trạng thái Lỗi (Error) |
| :---: | :---: |
| ![image](https://github.com/vvhoang04/10_baitap_flutter/blob/35201b1d48e622ab768846aa46bf9c8d91753502/Week1_CoreUI_State_Navigation/news_reader/img_news1.png)
![image](https://github.com/vvhoang04/10_baitap_flutter/blob/35201b1d48e622ab768846aa46bf9c8d91753502/Week1_CoreUI_State_Navigation/news_reader/img_news2.png) |

## 🛠️ Tính năng & Kỹ thuật đã sử dụng

-   **Kỹ thuật chính:** `FutureBuilder`, `async`/`await`, `http.get`
-   **Gói thư viện (Packages):**
    -   `http`: Để thực hiện các cuộc gọi API.
    -   `url_launcher`: Để mở link bài báo gốc trong trình duyệt (hoặc webview).
    -   `timeago`: Để hiển thị thời gian đăng bài một cách thân thiện (ví dụ: "2 hours ago").
-   **Giao diện (UI):**
    -   `ListView.builder` để hiển thị danh sách tin tức.
    -   `Card` với `elevation` và `shape` để tạo giao diện thẻ tin tức nổi bật.
    -   `Image.network` với `loadingBuilder` và `errorBuilder` để xử lý việc tải ảnh.
    -   `InkWell` để thêm hiệu ứng "gợn sóng" khi nhấn vào thẻ.
-   **Xử lý:**
    -   Hiển thị `CircularProgressIndicator` khi dữ liệu đang được tải.
    -   Hiển thị thông báo lỗi và nút "Try Again" khi gọi API thất bại.
    -   Nút "Refresh" trên `AppBar` để tải lại dữ liệu.

## 🚀 Cài đặt & Chạy dự án

Dự án này yêu cầu một **API Key** từ NewsAPI.org để hoạt động.

### ⚠️ Bước 1: Lấy API Key
1.  Truy cập [https://newsapi.org/](https://newsapi.org/) và đăng ký một tài khoản miễn phí.
2.  Sau khi đăng nhập, vào trang "Account" của bạn.
3.  Copy chuỗi **API Key** mà họ cung cấp.

### Bước 2: Thêm API Key vào dự án
1.  Mở file `lib/news_service.dart`.
2.  Tìm dòng này ở đầu file:
    ```dart
    final String _apiKey = "YOUR_API_KEY";
    ```
3.  Thay thế `"YOUR_API_KEY"` bằng API Key thật của bạn vừa copy.
    ```dart
    // Ví dụ:
    final String _apiKey = "a1b2c3d4e5f67890a1b2c3d4e5f67890";
    ```

### Bước 3: Chạy ứng dụng
1.  Đảm bảo bạn đã cài đặt các quyền (permissions) cho `url_launcher` trong file `Info.plist` (iOS) và `AndroidManifest.xml` (Android) như trong hướng dẫn.
2.  Lấy các gói phụ thuộc:
    ```bash
    flutter pub get
    ```
3.  Chạy ứng dụng:
    ```bash
    flutter run
    ```
