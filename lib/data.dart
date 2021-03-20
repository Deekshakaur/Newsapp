import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Article extends ChangeNotifier {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"]);
  }
  Future<List<Article>> getData(String newsType) async {
    List<Article> list;

    var res = await http.get(
      Uri.https('newsapi.org', 'v2/top-headlines', {
        'country': 'in',
        'apiKey': '95d2fabdfb224d69816a97df919591d3',
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Article>> getGeneralData(String newsType) async {
    List<Article> list;

    var res = await http.get(
      Uri.https('newsapi.org', 'v2/sources', {
        'category': 'general',
        'country': 'in',
        'apiKey': '95d2fabdfb224d69816a97df919591d3',
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Future<List<Article>> getSportsData(String newsType) async {
    List<Article> list;

    var res = await http.get(
      Uri.https('newsapi.org', 'v2/sources', {
        'category': 'sports',
        'country': 'in',
        'apiKey': '95d2fabdfb224d69816a97df919591d3',
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Future<List<Article>> getBusinessData(String newsType) async {
    List<Article> list;

    var res = await http.get(
      Uri.https('newsapi.org', 'v2/sources', {
        'category': 'business',
        'country': 'in',
        'apiKey': '95d2fabdfb224d69816a97df919591d3',
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Future<List<Article>> getEntertainmentData(String newsType) async {
    List<Article> list;

    var res = await http.get(
      Uri.https('newsapi.org', 'v2/sources', {
        'category': 'entertainment',
        'country': 'in',
        'apiKey': '95d2fabdfb224d69816a97df919591d3',
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}
