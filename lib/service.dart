import 'dart:convert';

import 'package:news_app/model.dart';
import 'package:http/http.dart' as http;

class NetworkHelper{

  static const API_KEY = 'e92425a72b4047e5b6af276431e0da99';
  static const DOMAIN = 'https://newsapi.org/v2';
  static Future<List<ArticleModel>> getArticles(String category) async{
    String uri = category != 'all' ? '$DOMAIN/top-headlines?country=eg&category=$category&apiKey=$API_KEY' :
    '$DOMAIN/top-headlines?country=eg&apiKey=$API_KEY';

    print('URL - $uri');
    var response = await http.get(Uri.parse(uri));

    print(response.statusCode);
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      print(result['articles']);

      return (result['articles'] as List).map((e) => ArticleModel.fromJson(e)).toList();
    }
    else
      {
        List<ArticleModel> articles;

        return articles;
      }
  }

  static Future<List<ArticleModel>> getArticlesBySearch(String q) async{

    String url = '$DOMAIN/everything?q=$q&from=2021-09-13&sortBy=publishedAt&apiKey=$API_KEY';
    print('URL - $url');
    List<ArticleModel> articles;
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      print(result['articles']);
      articles = (result['articles'] as List).map((e) => ArticleModel.fromJson(e)).toList();
    }
    else
        articles = null;

    return articles;
  }

}