# Project 5: Ứng dụng Ghi chú (Sử dụng Provider)

Đây là project nâng cao về quản lý trạng thái (State Management). Thay vì dùng `setState` (chỉ có tác dụng trong một widget), chúng ta chuyển sang sử dụng **Provider** để quản lý trạng thái toàn ứng dụng (app-wide state).

Ứng dụng cho phép người dùng tạo, xem, sửa, và xóa các ghi chú. Dữ liệu ghi chú được chia sẻ trên nhiều màn hình (Màn hình danh sách và Màn hình chỉnh sửa) một cách liền mạch.

## 🎯 Mục tiêu học tập

-   Hiểu lý do tại sao cần một giải pháp State Management (như Provider) thay cho `setState`.
-   Nắm vững 3 khái niệm cốt lõi của Provider:
    1.  **`ChangeNotifier`**: Tạo một class (ví dụ: `NoteProvider`) để chứa "state" (danh sách ghi chú) và các hàm logic (thêm, sửa, xóa). Gọi `notifyListeners()` khi state thay đổi.
    2.  **`ChangeNotifierProvider`**: "Cung cấp" (Provide) `NoteProvider` cho cây widget, thường đặt ở `main.dart` để toàn bộ ứng dụng có thể truy cập.
    3.  **`Consumer` / `Provider.of`**: "Sử dụng" (Consume) state. Dùng `Consumer` để lắng nghe thay đổi và tự động rebuild UI. Dùng `Provider.of(context, listen: false)` để gọi các hàm (như `addNote`) từ các sự kiện (như `onPressed`).
-   Điều hướng (navigate) giữa các màn hình và truyền dữ liệu (ví dụ: truyền `Note` cần sửa sang màn hình `AddEditNoteScreen`).
-   Sử dụng `TextFormField` và `Form` để lấy và xác thực (validate) dữ liệu đầu vào.

## 🖼️ Ảnh chụp màn hình

| Màn hình Danh sách | Màn hình Thêm/Sửa |
| :---: | :---: |
| ![image alt](https://github.com/vvhoang04/10_baitap_flutter/blob/1a90743d3117150dc6d846e2a26ba51a482e52d3/Week1_CoreUI_State_Navigation/note_app/img_note1.png) | ![image alt](https://github.com/vvhoang04/10_baitap_flutter/blob/1a90743d3117150dc6d846e2a26ba51a482e52d3/Week1_CoreUI_State_Navigation/note_app/img_note2.png) |

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **State Management:** `provider` (bao gồm `ChangeNotifier`, `ChangeNotifierProvider`, `Consumer`, `Provider.of`)
-   **Gói thư viện:** `uuid` (để tạo ID duy nhất cho mỗi ghi chú).
-   **Widget tương tác:** `FloatingActionButton`, `TextField` (dùng `TextFormField` với `GlobalKey<FormState>`), `AlertDialog` (để xác nhận xóa).
-   **Điều hướng:** `Navigator.push` và `Navigator.pop`.

## 🚀 Cách chạy dự án

1.  Lấy các gói phụ thuộc cần thiết:
    ```bash
    flutter pub add provider uuid
    flutter pub get
    ```
2.  Chạy ứng dụng:
    ```bash
    flutter run
    ```
