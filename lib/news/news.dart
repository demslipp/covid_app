import 'dart:convert';

import 'package:covid_app/models/article.dart';
import 'package:covid_app/news/key.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News {
  List<Article> news = [];

  Future<void> getNews(myFrom, myTo) async {

    Uri uri = Uri.http("newsapi.org", "/v2/everything", {"q" : "коронавирус", "language" : "ru",
      "from" : "$myFrom", "to" : "$myTo", "sortBy" : "publishedAt", "apiKey" : "$apiKey"});

    print("url check:" + uri.toString());

    var response = await http.get(uri);

    print(response.body);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategory {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    var to = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String myTo = formatter.format(to);
    print(myTo);
    var from = DateTime.now().subtract(Duration(days: 1));
    String myFrom = formatter.format(from);

    Uri uri = Uri.http("newsapi.org", "/v2/everything", {"q" : "$category",
      "from" : "$myFrom", "to" : "$myTo", "sortBy" : "publishedAt", "apiKey" : "$apiKey"});

    print("Uri check: " + uri.toString());

    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
