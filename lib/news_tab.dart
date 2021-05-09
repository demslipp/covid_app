

import 'package:covid_app/news.dart';
import 'package:covid_app/news_item.dart';
import 'package:flutter/material.dart';

class NewsTabController extends StatefulWidget {
  @override
  _NewsTabControllerState createState() => _NewsTabControllerState();
}

class _NewsTabControllerState extends State<NewsTabController> {
  List<News> newsList = [];

  @override
  void initState() {
    newsList.add((News(title: "Никита Михалков сделал прививку от коронавируса", description: "МOCKBA, 29 апр")));
    newsList.add((News(title: "Индия вновь установила мировой рекорд по числу заболевших COVID-19", description: "ИНДИЯ, 29 апр")));
    newsList.add((News(title: "В Киеве женщину парализовало после вакцинации", description: "КИЕВ, 28 апр")));
    newsList.add((News(title: "Индийский вариант коронавируса обнаружен в Китае", description: "ПЕКИН, 29 апр")));
    newsList.add((News(title: "Никита Михалков привился от коронавируса", description: "МOCKBA, 29 апр")));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: false,
          child: _listViewBuilder()),
      color: Colors.white70,
    ));
  }

  Widget _listViewBuilder() {
    return ListView.builder(
      itemExtent: null,
      itemCount: newsList.length,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          //You need to make my child interactive
            onTap: () {
              print(newsList[index].title + " tapped");
            },
            child: new NewsRowItem(news: newsList[index]));
      },
    );
  }
}


