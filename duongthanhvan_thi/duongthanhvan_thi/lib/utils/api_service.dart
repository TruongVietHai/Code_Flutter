import 'package:dio/dio.dart';
import 'package:vanduong_thi/entity/product2.dart';

class ApiService {
  static Future<List<Product2>> getAllProduct() async {
    var dio = Dio();
    
    // Thêm LogInterceptor để log các thông tin yêu cầu và phản hồi
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));  // Bật logging

    var response = await dio.request(
      'https://fakestoreapi.com/products',
      options: Options(
        method: 'GET',
      ),
    );

    await Future.delayed(const Duration(seconds: 3));  // Giả lập độ trễ

    if (response.statusCode == 200) {
      List<dynamic> rs = response.data;
      return rs.map((e) => Product2.fromJson(e)).toList();
    } else {
      print(response.statusMessage);  // In thông báo lỗi nếu có
      throw Exception(response.statusMessage);  // Ném ngoại lệ nếu không thành công
    }
  }
}
