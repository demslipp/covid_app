import 'package:covid_app/news.dart';
import 'package:flutter/material.dart';

class NewsRowItem extends StatelessWidget {
  const NewsRowItem({
    this.news,
  });

  final News news;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 8,
          top: 8,
          bottom: 0,
          right: 8,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          news.title,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          news.description != null
                              ? '${news.description}'
                              : 'Description is empty',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ));

    return Column(
      children: <Widget>[
        row,
      ],
    );
  }
}
