import 'package:flutter/material.dart';
import 'message_model.dart'; // Import model chúng ta vừa tạo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

// Màn hình chat chính (dùng StatefulWidget)
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // 1. Tạo một danh sách tin nhắn mẫu (mock data)
  final List<Message> _messages = [
    Message(text: 'Chào cậu!', isMe: false),
    Message(text: 'Chào! Cậu khoẻ không?', isMe: true),
    Message(text: 'Tớ khoẻ, cảm ơn. Cậu thì sao?', isMe: false),
    Message(text: 'Tớ cũng ổn. Đang làm project Flutter à?', isMe: true),
    Message(text: 'Đúng rồi, tớ đang làm bài tập Chat UI. Khó phết!', isMe: false),
    Message(text: 'Haha, cố lên! Nó dùng nhiều Row và Column lắm đó.', isMe: true),
    Message(text: 'Cảm ơn cậu nhé!', isMe: false),
    Message(text: '...', isMe: true),
  ];

  final TextEditingController _textController = TextEditingController();

  // Hàm (giả) để gửi tin nhắn
  void _handleSendPressed() {
    if (_textController.text.isNotEmpty) {
      // Khi gửi, ta thêm tin nhắn mới vào danh sách _messages
      // và gọi setState() để build lại UI
      setState(() {
        _messages.add(Message(text: _textController.text, isMe: true));
      });
      _textController.clear(); // Xóa text trong ô input
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Hiển thị avatar và tên người nhận
        title: Row(
          children: [
            CircleAvatar(
              // Bạn có thể thay bằng NetworkImage nếu có link ảnh
              backgroundColor: Colors.white,
              child: Text('B', style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(width: 12),
            Text('Bạn Bè'),
          ],
        ),
      ),
      body: Column( // (Yêu cầu) Dùng Column chia màn hình
        children: [
          // 2. Khu vực hiển thị tin nhắn
          Expanded(
            // (Yêu cầu) Dùng ListView.builder
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              // reverse: true giúp ListView bắt đầu từ dưới lên
              // giống hệt các app chat
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Để hiển thị đúng (vì list bị reverse),
                // ta sẽ lấy từ cuối danh sách lên
                final message = _messages[_messages.length - 1 - index];

                // Trả về widget bong bóng chat
                return _buildMessageBubble(message);
              },
            ),
          ),

          // 3. Khu vực nhập liệu
          _buildTextInputArea(),
        ],
      ),
    );
  }

  // Widget cho khu vực nhập liệu
  Widget _buildTextInputArea() {
    // (Yêu cầu) Dùng Container để tạo khung viền, đổ bóng...
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        // Thêm đường viền phía trên cho đẹp
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      // (Yêu cầu) Dùng Row để xếp TextField và Nút Gửi
      child: Row(
        children: [
          // TextField chiếm phần lớn không gian
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              // Cho phép nhấn Enter (nút submit) trên bàn phím để gửi
              onSubmitted: (text) => _handleSendPressed(),
            ),
          ),
          SizedBox(width: 8.0),
          // Nút gửi
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: _handleSendPressed,
          ),
        ],
      ),
    );
  }


  // --- Đây là phần quan trọng nhất của bài ---
  // Widget cho MỘT bong bóng tin nhắn
  Widget _buildMessageBubble(Message message) {
    // (Yêu cầu) Dùng Row để căn chỉnh tin nhắn sang trái hoặc phải
    return Row(
      // Căn lề: .end cho tin nhắn 'gửi', .start cho tin nhắn 'nhận'
      mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // (Yêu cầu) Dùng Container để tạo bong bóng chat
        Container(
          // Thêm giới hạn chiều rộng để tin nhắn không quá dài
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7, // Tối đa 70% chiều rộng màn hình
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            // Màu sắc tùy thuộc vào 'isMe'
            color: message.isMe
                ? Theme.of(context).primaryColor
                : Colors.grey[300],

            // Bo tròn các góc
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              // Bo tròn góc dưới-trái nếu là tin nhắn 'nhận'
              bottomLeft: Radius.circular(message.isMe ? 16 : 0),
              // Bo tròn góc dưới-phải nếu là tin nhắn 'gửi'
              bottomRight: Radius.circular(message.isMe ? 0 : 16),
            ),
          ),
          child: Text(
            message.text,
            style: TextStyle(
              // Màu chữ tùy thuộc vào 'isMe'
              color: message.isMe ? Colors.white : Colors.black87,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  // Đừng quên hủy controller
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}