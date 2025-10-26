import 'dart:io'; // Cần thiết để làm việc với đối tượng File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // Biến state: Dùng để lưu danh sách các file ảnh
  // Chúng ta cần import 'dart:io'
  final List<File> _images = [];

  // (Yêu"cầu) Khởi tạo ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Hàm xử lý logic chính
  Future<void> _pickImage(ImageSource source) async {
    // 1. (Yêu cầu) Xin quyền bằng permission_handler
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      // Đối với Android 13+, dùng Permission.photos.
      // Đối với cũ hơn, dùng Permission.storage.
      // permission_handler sẽ tự xử lý việc này.
      status = await Permission.photos.request();
    }

    // 2. Kiểm tra xem người dùng đã cấp quyền chưa
    if (status.isGranted) {
      // 3. (Yêu cầu) Mở camera/thư viện bằng image_picker
      final XFile? pickedFile = await _picker.pickImage(source: source);

      // 4. Xử lý kết quả (nếu người dùng có chọn ảnh)
      if (pickedFile != null) {
        // Cập nhật state để rebuild UI
        setState(() {
          _images.add(File(pickedFile.path));
        });
      } else {
        // Người dùng hủy (không chọn ảnh)
        print('User cancelled image picking.');
      }
    } else if (status.isDenied) {
      _showPermissionDeniedDialog('Permission was denied.');
    } else if (status.isPermanentlyDenied) {
      // Người dùng từ chối vĩnh viễn, cần mở cài đặt
      _showPermissionDeniedDialog(
          'Permission is permanently denied. Please open app settings to grant permission.');
    }
  }

  // Hiển thị dialog thông báo lỗi quyền
  void _showPermissionDeniedDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Permission Denied'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('Open Settings'),
            onPressed: () {
              Navigator.of(ctx).pop();
              openAppSettings(); // Mở cài đặt ứng dụng
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Photo Gallery'),
      ),
      body: Column(
        children: [
          // 1. Khu vực các nút bấm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Take Photo'),
                  onPressed: () {
                    _pickImage(ImageSource.camera); // Gọi hàm với nguồn là Camera
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text('From Gallery'),
                  onPressed: () {
                    _pickImage(ImageSource.gallery); // Gọi hàm với nguồn là Thư viện
                  },
                ),
              ],
            ),
          ),
          Divider(),

          // 2. (Yêu cầu) Khu vực GridView
          Expanded(
            child: _images.isEmpty
                ? Center(child: Text('No images selected.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    // Quy định số cột
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 ảnh trên 1 hàng
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      // Dùng Image.file để hiển thị ảnh từ file local
                      return Image.file(
                        _images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}