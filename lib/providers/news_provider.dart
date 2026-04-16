import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class NewsProvider with ChangeNotifier {
  List<News> _allNews = [];
  List<News> _displayNews = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<News> get displayNews => _displayNews;
  List<News> get favoriteNews => _allNews.where((n) => n.isFavorite).toList();
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        _allNews = data.map((item) => News.fromJson(item)).toList();
        _displayNews = _allNews;
      } else {
        _errorMessage = 'Lỗi kết nối API';
      }
    } catch (e) {
      _errorMessage = 'Không có kết nối mạng';
    }
    _isLoading = false;
    notifyListeners();
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      _displayNews = _allNews;
    } else {
      _displayNews = _allNews.where((n) => n.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void toggleFavorite(News news) {
    news.isFavorite = !news.isFavorite;
    notifyListeners();
  }
}