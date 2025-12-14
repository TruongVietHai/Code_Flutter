import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsArticle {
  final String title;
  final String imageUrl;
  final String content;

  NewsArticle({
    required this.title,
    required this.imageUrl,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json["title"] ?? "No title",
      imageUrl: json["urlToImage"] ?? "",
      // Ưu tiên content, nếu không có thì dùng description
      content: json["content"] ?? json["description"] ?? "",
    );
  }
}

class NewsApiService {
  // 🔹 BƯỚC 1: TỰ THAY API KEY Ở ĐÂY
  // Vào https://newsapi.org → đăng ký → lấy API key thật
  static const String _apiKey = "b842606858e7491db6a56443b908ee4a";

  static const String _baseUrl = "https://newsapi.org/v2/top-headlines";

  static Future<List<NewsArticle>> fetchNews() async {
    // 🔹 KHÔNG để dấu cách thừa, ghép query bằng string chuẩn
    final url = Uri.parse("$_baseUrl?country=us&apiKey=$_apiKey");

    try {
      final response = await http.get(url);

      // In log để debug khi lỗi
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List articles = data["articles"] ?? [];

        return articles.map((e) => NewsArticle.fromJson(e)).toList();
      } else {
        // In body để xem server trả gì
        print("Body: ${response.body}");
        throw Exception("Bad status: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ API ERROR (fetchNews): $e");
      throw Exception("Không thể tải tin tức");
    }
  }
}
