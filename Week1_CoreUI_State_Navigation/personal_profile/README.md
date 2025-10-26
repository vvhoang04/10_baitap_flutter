# Project 1: Ứng dụng Hồ sơ Cá nhân (Personal Profile)

Đây là project Flutter đầu tiên, tập trung vào việc xây dựng giao diện người dùng (UI) cơ bản, sắp xếp layout và xử lý responsive.

## 🎯 Mục tiêu học tập

Mục tiêu của dự án này là làm quen với các widget layout cơ bản của Flutter và hiểu cách cấu trúc một trang đơn giản.

-   Hiểu cách sử dụng `Column` để sắp xếp các phần tử theo chiều dọc.
-   Sử dụng `Card`, `ListTile`, và `CircleAvatar` để trình bày thông tin một cách rõ ràng, sạch sẽ.
-   Thêm assets (hình ảnh) vào dự án qua file `pubspec.yaml`.
-   Triển khai tính năng **Dark Mode** (chuyển đổi chế độ Sáng/Tối) bằng cách quản lý state ở widget cấp cao (`MaterialApp`) và truyền callback xuống widget con.
-   Làm quen với layout **responsive** cơ bản bằng cách dùng `SingleChildScrollView` (cho phép cuộn) và `ConstrainedBox` (giới hạn chiều rộng).

## 🖼️ Ảnh chụp màn hình

*(Bạn hãy thêm ảnh chụp màn hình ứng dụng của mình ở đây!)*

| Chế độ Sáng (Light Mode) | Chế độ Tối (Dark Mode) |
| :---: | :---: |
| <img src="URL_ANH_SANG.png" width="300"> | <img src="URL_ANH_TOI.png" width="300"> |

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **Layout:** `Column`, `Center`, `Padding`, `SizedBox`
-   **Widget hiển thị:** `Card`, `ListTile`, `CircleAvatar`, `Text`, `Icon`
-   **Tương tác:** `Switch` (để đổi theme)
-   **State:** Sử dụng `StatefulWidget` (`MyApp`) để quản lý `ThemeMode`.

## 🚀 Cách chạy dự án

1.  Đảm bảo bạn đã thêm ảnh đại diện vào `assets/images/profile.jpg` và cập nhật file `pubspec.yaml`.
2.  Lấy các gói phụ thuộc:
    ```bash
    flutter pub get
    ```
3.  Chạy ứng dụng:
    ```bash
    flutter run
    ```