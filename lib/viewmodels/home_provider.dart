import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/api_services.dart';


class NewsProvider extends ChangeNotifier {
  final ApiService _newsApiService;

  NewsProvider(this._newsApiService);

  News? _news;
  bool _isLoading = false;

  News? get news => _news;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    _news = await _newsApiService.fetchNews();

    _isLoading = false;
    notifyListeners();
  }
}
