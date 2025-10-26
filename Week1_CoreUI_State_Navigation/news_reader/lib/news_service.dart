// lib/news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart'; // Import model của chúng ta

class NewsService {
  // Thay API Key của bạn vào đây
  final String _apiKey = "5747e7cca7e14fcc9ed0fbc3fc8afe31";
  final String _baseUrl = "https://newsapi.org/v2";

  // Hàm này sẽ là một Future, vì nó cần thời gian để lấy dữ liệu
  // Nó sẽ trả về một List<Article>
  Future<List<Article>> fetchTopHeadlines() async {
    // Chúng ta lấy tin tức hàng đầu ở Mỹ
    final String url = '$_baseUrl/top-headlines?country=us&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      // 200 OK
      if (response.statusCode == 200) {
        // Decode chuỗi JSON
        final Map<String, dynamic> json = jsonDecode(response.body);

        // Lấy ra danh sách 'articles' từ JSON
        final List<dynamic> articlesJson = json['articles'];

        // Dùng .map để biến mỗi item JSON thành một đối tượng Article
        // và .toList() để chuyển nó thành một List<Article>
        List<Article> articles = articlesJson
            .map((item) => Article.fromJson(item))
            .toList();

        return articles;
      } else {
        // Nếu server trả về lỗi (ví dụ 404, 500)
        throw Exception('Failed to load news (Status code: ${response.statusCode})');
      }
    } catch (e) {
      // Bắt lỗi nếu không có mạng, hoặc API key sai
      print(e.toString());
      throw Exception('Failed to load news. Check your connection or API key.');
    }
  }
}