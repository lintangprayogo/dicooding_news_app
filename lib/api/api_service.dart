import 'dart:convert';

import 'package:dicoding_news_app/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '3ef841f7ee484e949c5d25e9d8fdcd3a';
  static const String _category = 'business';
  static const String _country = 'id';

  Future<ArticlesResult> topHeadLines() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));

    if (response.statusCode == 200) {
      var result = ArticlesResult.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception(response.body);
    }
  }
}
