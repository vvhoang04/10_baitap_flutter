# Project 10: Ứng dụng Đăng nhập (Firebase Login App)

Tập trung vào việc tích hợp một dịch vụ backend thực thụ: **Firebase Authentication**.

Ứng dụng này cung cấp một quy trình đăng ký (Register) và đăng nhập (Login) bằng Email/Password hoàn chỉnh. Nó sửâ dụng `StreamBuilder` để lắng nghe trạng thái xác thực (auth state) theo thời gian thực, tự động điều hướng người dùng đến trang chủ nếu đã đăng nhập, hoặc trang đăng nhập nếu chưa.

## 🎯 Mục tiêu học tập

-   Học cách tích hợp Firebase vào một ứng dụng Flutter.
-   Sử dụng **`firebase_core`** để khởi tạo kết nối với Firebase.
-   Sử dụng **`firebase_auth`** để thực hiện các hành động:
    -   `createUserWithEmailAndPassword` (Đăng ký)
    -   `signInWithEmailAndPassword` (Đăng nhập)
    -   `signOut` (Đăng xuất)
-   Sử dụng **`StreamBuilder`** kết hợp với `FirebaseAuth.instance.authStateChanges()` để lắng nghe trạng thái đăng nhập của người dùng một cách "live".
-   Tạo một "Auth Gate" (Cổng xác thực) để tự động điều hướng người dùng.
-   Xử lý lỗi (Error Handling) từ `FirebaseAuthException` (ví dụ: sai mật khẩu, email đã tồn tại).
-   Hiểu quy trình cài đặt Firebase cho cả Android và iOS, bao gồm cả việc sử dụng `flutterfire_cli`.

## 🖼️ Ảnh chụp màn hình

*(Bạn hãy thêm ảnh chụp màn hình ứng dụng của mình ở đây!)*

| Màn hình Đăng nhập | Màn hình Đăng ký | Màn hình Trang chủ |
| :---: | :---: | :---: |
| <img src="URL_ANH_DANG_NHAP.png" width="300"> | <img src="URL_ANH_DANG_KY.png" width="300"> | <img src="URL_ANH_TRANG_CHU.png" width="300"> |

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **Gói thư viện (Firebase):**
    -   `firebase_core`: Gói lõi để khởi tạo Firebase.
    -   `firebase_auth`: Gói xác thực người dùng.
-   **State Management:** `StreamBuilder` (để quản lý trạng thái đăng nhập).
-   **Kiến trúc:** `AuthGate` (để điều hướng), `LoginOrRegisterScreen` (để bật/tắt UI).
-   **Công cụ:** `flutterfire_cli` và `firebase-tools` (để cấu hình).

## 🚀 Cài đặt & Chạy dự án (CỰC KỲ QUAN TRỌNG)

Project này **KHÔNG THỂ CHẠY** nếu chỉ "clone" về. Bạn **BẮT BUỘC** phải tự tạo project Firebase của riêng mình và kết nối nó.

### Bước 1: Tạo Project Firebase
1.  Truy cập [Firebase Console](https://console.firebase.google.com/).
2.  Nhấn **"Add project" (Thêm dự án)** và tạo một project mới.
3.  Bên trong project, vào mục **Authentication** (Xác thực).
4.  Nhấn "Get started" -> "Sign-in method".
5.  Chọn **"Email/Password"** và **Bật (Enable)** nó lên.

### Bước 2: Cài đặt Công cụ Firebase
Bạn cần 2 công cụ command-line: `firebase-tools` (công cụ chính) và `flutterfire_cli` (công cụ cho Flutter).

1.  **Cài `firebase-tools`:** (Cần [Node.js](https://nodejs.org/) đã cài)
    ```bash
    npm install -g firebase-tools
    ```
2.  **Đăng nhập Firebase:**
    ```bash
    firebase login
    ```
    *(Một trình duyệt sẽ mở ra, hãy đăng nhập vào tài khoản Google bạn đã dùng ở Bước 1)*

3.  **Cài `flutterfire_cli`:** (Bạn có thể đã cài trong `dev_dependencies`, nếu không hãy chạy lệnh global)
    ```bash
    dart pub global activate flutterfire_cli
    ```

### Bước 3: Cấu hình Project Flutter
1.  Lấy các gói phụ thuộc (nếu chưa có `firebase_core`, `firebase_auth`):
    ```bash
    flutter pub add firebase_core firebase_auth
    ```
2.  **Cấu hình Android (Quan trọng):**
    Mở file `android/app/build.gradle` (hoặc `build.gradle.kts`) và đảm bảo `minSdk` là **21** hoặc cao hơn.
    ```gradle
    defaultConfig {
        minSdk 21
        // ...
    }
    ```
3.  **Chạy `flutterfire configure`:**
    Trong thư mục gốc của project Flutter (`firebase_login`), chạy lệnh:
    ```bash
    flutterfire configure
    ```
    *(Nếu lệnh này không chạy, hãy dùng: `dart pub global run flutterfire_cli configure` hoặc `dart run flutterfire_cli:flutterfire configure`)*

4.  **Làm theo hướng dẫn:**
    * Chọn project Firebase bạn đã tạo ở Bước 1.
    * Chọn các nền tảng (platforms) `android` và `ios`.
    * Công cụ sẽ tự động tạo file `lib/firebase_options.dart` và cấu hình các file native.

### Bước 4: Chạy ứng dụng
Sau khi Bước 3 hoàn tất và file `lib/firebase_options.dart` đã được tạo:

1.  **Dừng (Stop)** ứng dụng hoàn toàn (nếu đang chạy).
2.  (Nên làm) Chạy `flutter clean`:
    ```bash
    flutter clean
    ```
3.  Chạy lại ứng dụng:
    ```bash
    flutter run
    ```