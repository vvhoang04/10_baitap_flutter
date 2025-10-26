# Project 2: Ứng dụng Todo (Quản lý State Cục bộ)

Đây là project Flutter thứ hai, tập trung vào khái niệm quan trọng nhất: **State Management**. Ứng dụng này là một danh sách công việc (Todo List) đơn giản, cho phép người dùng thêm, hoàn thành và xóa công việc.

## 🎯 Mục tiêu học tập

Mục tiêu chính là hiểu rõ cách `StatefulWidget` và hàm `setState()` hoạt động để cập nhật giao diện người dùng (UI) khi dữ liệu thay đổi.

-   Sử dụng `StatefulWidget` để "nhớ" và lưu trữ một danh sách (`List`) các công việc.
-   Hiểu rõ vai trò của `setState()`: Bất cứ khi nào danh sách công việc thay đổi (thêm, sửa, xóa), chúng ta phải gọi `setState()` để báo cho Flutter "vẽ lại" màn hình.
-   Sử dụng `ListView.builder()` để hiển thị hiệu quả một danh sách có độ dài động (dynamic list).
-   Lấy dữ liệu người dùng nhập vào bằng `TextField` và `TextEditingController`.
-   Tạo các hàm (`_addTask`, `_toggleTask`, `_deleteTask`) để thao tác logic với state.

**Quan trọng:** Project này sử dụng **Local State** (trạng thái cục bộ). Điều này có nghĩa là mọi công việc sẽ bị MẤT khi bạn khởi động lại ứng dụng.

## 🖼️ Ảnh chụp màn hình

*(Bạn hãy thêm ảnh chụp màn hình ứng dụng của mình ở đây!)*

![Ảnh chụp màn hình Todo App](URL_ANH_TODO_APP.png)

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **State:** `StatefulWidget`, `setState()`
-   **Widget danh sách:** `ListView.builder`
-   **Widget tương tác:** `CheckboxListTile`, `IconButton`, `TextField`
-   **Quản lý input:** `TextEditingController`
-   **Cấu trúc dữ liệu:** Sử dụng một class `Task` (model) để biểu diễn dữ liệu công việc.

## 🚀 Cách chạy dự án

1.  Lấy các gói phụ thuộc (mặc dù project này không cần gói ngoài):
    ```bash
    flutter pub get
    ```
2.  Chạy ứng dụng:
    ```bash
    flutter run
    ```