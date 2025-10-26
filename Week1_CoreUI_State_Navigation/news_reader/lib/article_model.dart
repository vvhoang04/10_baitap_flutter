// lib/article_model.dart

// Class này đại diện cho cấu trúc của 1 bài báo
class Article {
  final String title;
  final String? description; // Có thể null
  final String url;
  final String? urlToImage; // Có thể null
  final String sourceName;
  final DateTime publishedAt;

  Article({
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.sourceName,
    required this.publishedAt,
  });

  // Một factory constructor để parse JSON
  // Đây là cách làm rất phổ biến
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      sourceName: json['source'] != null ? json['source']['name'] : 'Unknown Source',
      publishedAt: DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
    );
  }
}