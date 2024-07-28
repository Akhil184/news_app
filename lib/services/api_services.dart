// news_api_service.dart
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/news_model.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = 'dbf5d486ff72443a9e023e3f81e8eb58';

  late final RemoteConfig remoteConfig;

  ApiService(this.remoteConfig);

  Future<News?> fetchNews() async {
    final countryCode = remoteConfig.getString('country_code');
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?country=$countryCode&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      print(response.body);
      return News.fromJson(json.decode(response.body));
    } else {
      // Handle error
      return null;
    }
  }
}

