import 'package:flutter/material.dart';

// 1. Hàm main() khởi chạy ứng dụng
void main() {
  runApp(MyApp());
}

// 2. MyApp (StatelessWidget) - Cài đặt MaterialApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoScreen(), // Màn hình chính của chúng ta
    );
  }
}

// 3. (Tùy chọn) Tạo một class Model cho công việc
// Điều này giúp code sạch sẽ hơn là dùng Map hay List<String>
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

// 4. TodoScreen (StatefulWidget) - Màn hình chính
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

// 5. _TodoScreenState - Nơi chứa "State" (trạng thái)
class _TodoScreenState extends State<TodoScreen> {
  // --- STATE VARIABLES ---

  // (Yêu cầu) Đây là danh sách các công việc, là "trạng thái" của chúng ta
  final List<Task> _tasks = [];

  // Controller để lấy text từ TextField
  final TextEditingController _taskController = TextEditingController();

  // --- STATE MANAGEMENT FUNCTIONS ---

  // Hàm thêm công việc mới
  void _addTask() {
    // Chỉ thêm nếu TextField không rỗng
    if (_taskController.text.isNotEmpty) {
      // (Yêu cầu) Gọi setState() để thông báo cho Flutter cập nhật UI
      setState(() {
        // Thêm một Task mới vào danh sách _tasks
        _tasks.add(Task(title: _taskController.text));
      });
      // Xóa nội dung trong TextField sau khi thêm
      _taskController.clear();
    }
  }

  // Hàm đánh dấu hoàn thành (hoặc hủy hoàn thành)
  void _toggleTask(int index) {
    // (Yêu cầu) Gọi setState()
    setState(() {
      // Đảo ngược trạng thái isDone của công việc tại vị trí index
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  // Hàm xóa công việc
  void _deleteTask(int index) {
    // (Yêu cầu) Gọi setState()
    setState(() {
      // Xóa công việc tại vị trí index khỏi danh sách
      _tasks.removeAt(index);
    });
  }

  // --- UI (build method) ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
      ),
      body: Column(
        children: [
          // Phần 1: Danh sách công việc (Yêu cầu: ListView.builder)
          Expanded(
            // ListView.builder hiệu quả hơn ListView() vì nó chỉ render
            // các item đang hiển thị trên màn hình.
            child: ListView.builder(
              itemCount: _tasks.length, // Số lượng item = độ dài danh sách
              itemBuilder: (context, index) {
                // Lấy ra công việc hiện tại
                final task = _tasks[index];

                // CheckboxListTile là một widget tiện lợi
                // kết hợp Checkbox và ListTile
                return CheckboxListTile(
                  title: Text(
                    task.title,
                    // Thêm style gạch ngang nếu công việc đã hoàn thành
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isDone ? Colors.grey : null,
                    ),
                  ),
                  // 'value' điều khiển việc checkbox có được tick hay không
                  value: task.isDone,
                  // 'onChanged' được gọi khi người dùng nhấn vào checkbox
                  onChanged: (newValue) {
                    // Gọi hàm _toggleTask để cập nhật state
                    _toggleTask(index);
                  },
                  // Thêm một nút để xóa
                  secondary: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red[300]),
                    onPressed: () {
                      // Gọi hàm _deleteTask để cập nhật state
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),

          // Phần 2: Vùng nhập liệu để thêm công việc mới
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // TextField để người dùng nhập tên công việc
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Cho phép nhấn "Enter" trên bàn phím để thêm
                    onSubmitted: (value) => _addTask(),
                  ),
                ),
                SizedBox(width: 8),
                // Nút "Add"
                IconButton(
                  icon: Icon(Icons.add_circle, size: 40.0),
                  color: Theme.of(context).primaryColor,
                  onPressed: _addTask, // Gọi hàm _addTask khi nhấn
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // (Quan trọng) Hủy controller khi widget bị xóa
  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}