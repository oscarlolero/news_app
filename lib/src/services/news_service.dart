import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/models/category.dart';

final _urlNews = 'https://newsapi.org/v2';
final _apiKey = 'ef3fd625afa242f081f72979bd4d8e9c';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  NewsService() {
    this.getTopHeadLines();
  }

  getTopHeadLines() async {

    final url = '$_urlNews/top-headlines?country=mx&apiKey=$_apiKey';
    final response = await http.get(url);

    final newsResponse = newsResponseFromJson(response.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

}