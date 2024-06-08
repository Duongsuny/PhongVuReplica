import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phongvu_copycat/models/product.dart';


class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Product> fetchProduct() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      return Product.fromJson(json);
    } else {
      throw Exception('Failed to load product');
    }
  }
}
