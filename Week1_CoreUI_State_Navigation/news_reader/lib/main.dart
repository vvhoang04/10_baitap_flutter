import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'article_model.dart'; // Import model
import 'news_service.dart'; // Import service

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system, // Tự động theo hệ thống
      home: NewsListScreen(),
    );
  }
}

// Đây là màn hình chính, dùng StatefulWidget
class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  // Chúng ta cần một biến để giữ "Future"
  // 'late' nghĩa là "Tôi sẽ gán giá trị cho nó sau, trước khi dùng"
  late Future<List<Article>> _newsFuture;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    // Gọi hàm fetch news ngay khi màn hình được tạo
    _fetchNews();
  }

  // Hàm để gọi API và gán kết quả cho _newsFuture
  void _fetchNews() {
    setState(() {
      _newsFuture = _newsService.fetchTopHeadlines();
    });
  }

  // Hàm để mở URL (Yêu cầu: open details)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      // Hiển thị lỗi nếu không thể mở link
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    } else {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
        actions: [
          // Thêm nút refresh để tải lại tin tức
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchNews,
          ),
        ],
      ),
      // (Yêu cầu) Dùng FutureBuilder
      body: FutureBuilder<List<Article>>(
        future: _newsFuture, // Future mà chúng ta muốn theo dõi
        builder: (context, snapshot) {

          // (Yêu cầu) Trạng thái Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // (Yêu cầu) Trạng thái Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 50),
                    SizedBox(height: 10),
                    Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _fetchNews,
                      child: Text('Try Again'),
                    )
                  ],
                ),
              ),
            );
          }

          // (Yêu cầu) Trạng thái Success (có data)
          if (snapshot.hasData) {
            final articles = snapshot.data!;

            // Nếu không có bài báo nào
            if (articles.isEmpty) {
              return Center(child: Text('No articles found.'));
            }

            // Hiển thị danh sách tin tức
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                // Chúng ta sẽ tạo một widget riêng cho đẹp
                return NewsCard(
                  article: articles[index],
                  onTap: () => _launchURL(articles[index].url),
                );
              },
            );
          }

          // Trạng thái mặc định (thường là loading)
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// --- (Phần Nâng Cấp Giao Diện) ---
// Widget Card tùy chỉnh để hiển thị tin tức
class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const NewsCard({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      // Card với viền bo tròn và đổ bóng
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias, // Để bo tròn cả hình ảnh bên trong
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        // InkWell để có hiệu ứng gợn sóng khi nhấn
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hình ảnh (urlToImage)
              // Kiểm tra nếu urlToImage bị null
              if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
                Image.network(
                  article.urlToImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Hiển thị loading khi đang tải ảnh
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  // Hiển thị icon lỗi nếu không tải được ảnh
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                    );
                  },
                )
              else
                // Placeholder nếu không có ảnh
                Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
                ),

              // 2. Tiêu đề (title)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  article.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // 3. Mô tả (description)
              if (article.description != null && article.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    article.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              // 4. Nguồn và Thời gian (Nâng cấp UI)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Nguồn tin
                    Expanded(
                      child: Text(
                        article.sourceName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10),
                    // Thời gian đăng (dùng timeago)
                    Text(
                      timeago.format(article.publishedAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}