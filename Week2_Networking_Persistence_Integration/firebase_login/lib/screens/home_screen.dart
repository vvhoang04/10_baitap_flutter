// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {

  // Hàm xử lý Đăng xuất
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Lấy thông tin user hiện tại
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Lấy email (hoặc 'U' nếu không có)
  String get userEmail => currentUser?.email ?? 'No Email';
  String get userInitial => userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'U';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar được thiết kế lại
      appBar: AppBar(
        title: Text('My Dashboard'),
        backgroundColor: Colors.transparent, // Nền trong suốt
        elevation: 0, // Không đổ bóng
        foregroundColor: Theme.of(context).primaryColor, // Màu chữ theo theme
      ),
      // 2. Thêm màu nền cho body
      backgroundColor: Color(0xFFF5F5F5), // Màu xám rất nhạt
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 3. Lời chào
            Text(
              'Welcome back,',
              style: TextStyle(fontSize: 22, color: Colors.grey[700]),
            ),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            SizedBox(height: 30),

            // 4. Thẻ thông tin người dùng (Profile Card)
            Card(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      child: Text(
                        userInitial,
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Tên & Email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Logged in as',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Nút Logout
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.red[400]),
                      tooltip: 'Logout',
                      onPressed: _signOut,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // 5. Lưới chức năng (Dashboard Grid)
            Text(
              'Your Tools',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2, // 2 cột
              shrinkWrap: true, // Cần thiết khi lồng GridView trong Column
              physics: NeverScrollableScrollPhysics(), // Không cho GridView cuộn
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                  context,
                  icon: Icons.person_outline,
                  title: 'My Profile',
                  color: Colors.blue,
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.bar_chart,
                  title: 'Statistics',
                  color: Colors.green,
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  color: Colors.orange,
                ),
                _buildDashboardCard(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper để tạo thẻ cho GridView
  Widget _buildDashboardCard(BuildContext context, {required IconData icon, required String title, required Color color}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Xử lý khi nhấn vào (ví dụ: điều hướng)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title tapped!')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}