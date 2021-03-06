import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/models/category.dart';

final _urlNews = 'https://newsapi.org/v2';
final _apiKey = 'ef3fd625afa242f081f72979bd4d8e9c';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesFromSelectedCategory => this.categoryArticles[this._selectedCategory];

  getTopHeadLines() async {

    final url = '$_urlNews/top-headlines?country=mx&apiKey=$_apiKey';
    final response = await http.get(url);

    final newsResponse = newsResponseFromJson(response.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

  getArticlesByCategory(String category) async {

    if(this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }

    final url = '$_urlNews/top-headlines?country=mx&category=$category&apiKey=$_apiKey';
    final response = await http.get(url);

    final newsResponse = newsResponseFromJson(response.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    notifyListeners();

  }

}