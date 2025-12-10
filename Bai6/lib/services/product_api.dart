import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductApi {
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$_baseUrl/products');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Không tải được danh sách sản phẩm. Mã lỗi: ${response.statusCode}');
    }
  }
}
