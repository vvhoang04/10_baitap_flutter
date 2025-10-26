# Project 7: Ứng dụng Quản lý Chi tiêu (Expense Tracker)

Đây là project tập trung vào việc **lưu trữ dữ liệu vĩnh viễn (Persistence)** trên thiết bị. Ứng dụng cho phép người dùng ghi lại các khoản chi tiêu hàng ngày và xem lại chúng dưới dạng danh sách cũng như biểu đồ thống kê.

Điểm mấu chốt của project này là sử dụng cơ sở dữ liệu NoSQL cục bộ (`Hive`) để dữ liệu không bị mất khi đóng ứng dụng, và trực quan hóa dữ liệu đó bằng biểu đồ (`fl_chart`).

## 🎯 Mục tiêu học tập

-   Học cách tích hợp và sử dụng một cơ sở dữ liệu local trong Flutter.
-   Hiểu và sử dụng **`Hive`**, một CSDL NoSQL siêu nhanh viết bằng Dart:
    -   Định nghĩa `class` Model với các Annotation (`@HiveType`, `@HiveField`).
    -   Sử dụng `build_runner` và `hive_generator` để tự động sinh code `Adapter`.
    -   Khởi tạo (`init`), đăng ký (`registerAdapter`), và mở (`openBox`) Hive trước khi chạy ứng dụng.
    -   Thực hiện các thao tác CRUD cơ bản (Create: `box.add()`, Read: `box.values`, Delete: `box.deleteAt()`).
    -   Sử dụng `ValueListenableBuilder` để tự động rebuild UI khi dữ liệu trong Box thay đổi.
-   Sử dụng thư viện **`fl_chart`** để trực quan hóa dữ liệu (vẽ biểu đồ cột).
-   Xử lý logic để nhóm (group) và tổng hợp (aggregate) dữ liệu chi tiêu theo ngày.
-   Sử dụng `path_provider` để tìm đúng thư mục lưu trữ file CSDL trên cả Android và iOS.

## 🖼️ Ảnh chụp màn hình

*(Bạn hãy thêm ảnh chụp màn hình ứng dụng của mình ở đây!)*

| Danh sách Chi tiêu | Biểu đồ Thống kê |
| :---: | :---: |
| <img src="URL_ANH_DANH_SACH_CHI_TIEU.png" width="300"> | <img src="URL_ANH_BIEU_DO_CHI_TIEU.png" width="300"> |

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **Cơ sở dữ liệu (Local Storage):** `hive`, `hive_flutter`
-   **Trực quan hóa Dữ liệu:** `fl_chart` (dùng `BarChart`)
-   **Hệ thống:** `path_provider` (để lấy đường dẫn lưu file)
-   **Sinh code:** `hive_generator`, `build_runner` (trong `dev_dependencies`)
-   **UI:** `BottomAppBar` với `CircularNotchedRectangle`, `FloatingActionButton`, `showDatePicker`.
-   **State:** `ValueListenableBuilder` (cách lắng nghe thay đổi của Hive).

## 🚀 Cài đặt & Chạy dự án

Dự án này yêu cầu một bước **Sinh code** để hoạt động.

### 1. Cài đặt Thư viện
Đảm bảo `pubspec.yaml` của bạn có đủ các thư viện:
-   `dependencies`: `hive`, `hive_flutter`, `fl_chart`, `path_provider`, `intl`
-   `dev_dependencies`: `hive_generator`, `build_runner`

Sau đó, chạy:
```bash
flutter pub get