import 'package:dicoding_news_app/api/api_service.dart';
import 'package:dicoding_news_app/model/article.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    _fetchAllArticles();
  }

  late ArticlesResult _articlesResult;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  ArticlesResult get result => _articlesResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticles() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.topHeadLines();

      if (result.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _articlesResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
