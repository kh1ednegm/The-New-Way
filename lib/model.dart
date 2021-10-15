

import 'dart:math';

class ArticleModel{
  String author,title,description,url,urlToImage,publishedAt;
  Source source;
  int flag;

   ArticleModel.fromJson(Map<String,dynamic> json){
     author = json['author'];
     title = json['title'];
     description = json['description'];
     url = json['url'];
     urlToImage = json['urlToImage'];
     publishedAt = json['publishedAt'];
     source = Source.fromJson(json['source']);
     flag = 1 + Random().nextInt(3);
  }
}

class Source {
  String name;

  Source.fromJson(Map<String,dynamic> json){
    name = json['name'];
  }
}

