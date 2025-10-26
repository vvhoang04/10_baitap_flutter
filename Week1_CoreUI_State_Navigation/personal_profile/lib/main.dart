import 'package:flutter/material.dart';

// 1. Hàm main() khởi chạy ứng dụng
void main() {
  runApp(MyApp());
}

// 2. MyApp là widget gốc, dùng StatefulWidget để quản lý ThemeMode
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Biến _themeMode sẽ lưu trạng thái Sáng (light) hoặc Tối (dark)
  ThemeMode _themeMode = ThemeMode.light;

  // Hàm này dùng để thay đổi theme, và sẽ được truyền xuống ProfilePage
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile',
      debugShowCheckedModeBanner: false, // Tắt banner "DEBUG"

      // Cấu hình Theme Sáng
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // Cấu hình Theme Tối
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // Dùng biến _themeMode để quyết định theme nào được áp dụng
      themeMode: _themeMode,

      // Trang chủ của ứng dụng
      home: ProfilePage(
        // Truyền hàm toggle theme xuống cho trang ProfilePage
        onThemeToggled: _toggleTheme,
        // Truyền trạng thái hiện tại của theme
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

// 3. ProfilePage là trang chính hiển thị thông tin
class ProfilePage extends StatelessWidget {
  // Nhận hàm callback và trạng thái dark mode từ MyApp
  final Function(bool) onThemeToggled;
  final bool isDarkMode;

  ProfilePage({
    required this.onThemeToggled,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          // Đây là nút Toggle Dark Mode
          Switch(
            value: isDarkMode,
            onChanged: onThemeToggled, // Gọi hàm callback khi gạt switch
          ),
        ],
      ),
      // SingleChildScrollView cho phép nội dung cuộn khi không đủ chỗ (responsive)
      body: SingleChildScrollView(
        // Center để căn giữa nội dung trên màn hình lớn (tablet/desktop)
        child: Center(
          // ConstrainedBox giới hạn chiều rộng tối đa, giúp dễ đọc trên màn hình rộng
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            // Padding để tạo khoảng đệm xung quanh nội dung
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // Column để sắp xếp các widget theo chiều dọc
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Yêu cầu: CircleAvatar cho ảnh đại diện
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/images/avata.jpg'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'HoangDev', // Thay bằng tên của bạn
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Flutter Developer | Tech Enthusiast', // Thay bằng bio của bạn
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),

                  // Yêu cầu: Card để nhóm các kỹ năng
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skills',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 16),
                          // Yêu cầu: ListTile cho từng kỹ năng
                          SkillTile(
                            icon: Icons.data_object,
                            skill: 'Dart & Flutter',
                          ),
                          SkillTile(
                            icon: Icons.storage,
                            skill: 'Firebase',
                          ),
                          SkillTile(
                            icon: Icons.design_services,
                            skill: 'UI/UX Design',
                          ),
                          SkillTile(
                            icon: Icons.public,
                            skill: 'REST APIs',
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Yêu cầu: Card để nhóm các link social
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Social Links',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 16),
                          // Yêu cầu: ListTile cho từng link
                          SocialTile(
                            icon: Icons.link, // Bạn có thể dùng FontAwesome icons cho đẹp hơn
                            platform: 'GitHub',
                            username: '/your-github',
                          ),
                          SocialTile(
                            icon: Icons.link,
                            platform: 'LinkedIn',
                            username: '/in/your-linkedin',
                          ),
                          SocialTile(
                            icon: Icons.link,
                            platform: 'Twitter / X',
                            username: '@your-twitter',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget tái sử dụng cho Kỹ năng (dùng ListTile)
class SkillTile extends StatelessWidget {
  final IconData icon;
  final String skill;

  SkillTile({required this.icon, required this.skill});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(skill),
    );
  }
}

// Widget tái sử dụng cho Social Link (dùng ListTile)
class SocialTile extends StatelessWidget {
  final IconData icon;
  final String platform;
  final String username;

  SocialTile({
    required this.icon,
    required this.platform,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(platform),
      subtitle: Text(username),
      onTap: () {
        // Bạn có thể thêm hành động mở link ở đây (ví dụ dùng url_launcher)
        print('Opening $platform link...');
      },
    );
  }
}