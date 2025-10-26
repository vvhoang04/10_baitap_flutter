// lib/message_model.dart

class Message {
  final String text;
  final bool isMe; // true = tin nhắn gửi, false = tin nhắn nhận

  Message({required this.text, required this.isMe});
}