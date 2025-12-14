import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/search_response.dart';

class PixabayService {
  // TODO: Thay bằng API key của bạn
  static const String _apiKey = '23361083-8bb4d7be8c9cfe6723a356cda';
  static const String _baseUrl = 'https://pixabay.com/api';

  Future<SearchResponse> searchImages({
    String query = '',
    String? category,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'key': _apiKey,
      'q': query,
      'image_type': 'photo',
      'per_page': '50',
      if (category != null && category.isNotEmpty) 'category': category,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return SearchResponse.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load images: ${response.statusCode}');
    }
  }
}
