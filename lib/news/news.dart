import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:covid_app/models/article.dart';
import 'dart:convert';
import 'package:covid_app/news/key.dart';

class News {

  List<Article> news = [];
  Future<void> getNews(myFrom, myTo) async {
    String url =
        "http://newsapi.org/v2/everything?q=коронавирус&language=ru&from=$myFrom&to=$myTo&sortBy=publishedAt&apiKey=$apiKey";;
    print("url check:  " + url);
    var response = await http.get(url);

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
    var from = DateTime.now().subtract(Duration(days:1));
    String myFrom = formatter.format(from);
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/everything?q=$category&from=$myFrom&to=$myTo&sortBy=publishedAt&apiKey=$apiKey";
    print("url check: " + url);
    var response = await http.get(url);

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
