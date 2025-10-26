# Project 4: Giao diện Chat (Chat UI Clone)

Đây là project tập trung vào việc xây dựng các layout phức tạp, lồng ghép nhau và xử lý danh sách cuộn, mô phỏng lại giao diện của các ứng dụng chat phổ biến như Messenger hay WhatsApp.

Project này là bài tập quan trọng để làm chủ `Row`, `Column` và `Container` trong việc sắp xếp các thành phần UI một cách linh hoạt.

## 🎯 Mục tiêu học tập

-   Luyện tập xây dựng các layout lồng ghép (nested layouts) phức tạp.
-   Sử dụng `ListView.builder` với thuộc tính `reverse: true` để tạo danh sách tin nhắn cuộn từ dưới lên.
-   Làm chủ `Container` để tùy chỉnh `decoration` (màu sắc, bo góc) nhằm tạo ra các "bong bóng chat" (message bubbles) động.
-   Kết hợp `Row` và `MainAxisAlignment` để đẩy bong bóng chat sang trái hoặc phải (tin nhắn nhận/gửi).
-   Sử dụng `Column` và `Expanded` để chia màn hình thành khu vực tin nhắn (cuộn được) và khu vực nhập liệu (cố định).

## 🖼️ Ảnh chụp màn hình

*(Bạn hãy thêm ảnh chụp màn hình ứng dụng của mình ở đây!)*

| Giao diện chính |
| :---: |
| <img src="URL_ANH_CHAT_UI.png" width="300"> |

## 🛠️ Yêu cầu kỹ thuật đã sử dụng

-   **Layout:** `Column`, `Row`, `Expanded`, `Container`
-   **Widget danh sách:** `ListView.builder` (với `reverse: true`)
-   **Widget nhập liệu:** `TextField`, `IconButton`
-   **Tùy chỉnh UI:** `BoxDecoration`, `BorderRadius` để tạo hình dạng bong bóng chat.
-   **Quản lý State:** Sử dụng `setState` cơ bản để thêm tin nhắn mới vào danh sách (bản demo).

## 🚀 Cách chạy dự án

1.  Lấy các gói phụ thuộc (nếu có):
    ```bash
    flutter pub get
    ```
2.  Chạy ứng dụng:
    ```bash
    flutter run
    ```