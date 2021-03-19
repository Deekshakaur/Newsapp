import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'dart:ui';
import '../ReadNews/readnews.dart';
import '../../data.dart';
import 'dart:async';

class App extends StatefulWidget {
  static const id = 'app';
  String newsType = '';
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Widget newsBuilder(List<Article> article) {
    return Container(
      height: MediaQuery.of(context).size.height * .45,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 19,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return BreakingNewsBuilder(
              url: article[position].url,
              author: article[position].author,
              title: article[position].title,
              content: article[position].content,
              description: article[position].description,
              publishedAt: article[position].publishedAt,
              source: article[position].source,
              urlToImage: article[position].urlToImage ??
                  'https://s3.amazonaws.com/speedsport-news/speedsport-news/wp-content/uploads/2018/07/01082232/image-not-found.png',
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Article>(
      builder: (context, data, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReadNews(
                                  content: data.content,
                                  author: data.author,
                                  imageUrl: data.urlToImage,
                                  desc: data.description,
                                  title: data.title,
                                  url: data.url,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            '',
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(kRoundedcornersradius),
                          bottomRight: Radius.circular(kRoundedcornersradius)),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: kPadding * 1.5, vertical: kPadding * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRect(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: kPadding / 2,
                                      horizontal: kPadding),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(
                                        kRoundedcornersradius),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.5, sigmaY: 10.6),
                                    child: Text(
                                      ('kfhhasj'),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${data.title}",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                margin:
                                    EdgeInsets.symmetric(vertical: kPadding),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Learn More',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.east_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.40,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(kPadding * 1.5, kPadding * 2,
                      kPadding * 1.5, kPadding * 1.25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breaking News',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .55,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return snapshot.data == null
                          ? Center(
                              child: CircularProgressIndicator.adaptive(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ))
                          : newsBuilder(snapshot.data);
                    },
                    future: data.getData(widget.newsType),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BreakingNewsBuilder extends StatelessWidget {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  BreakingNewsBuilder(
      {this.urlToImage,
      this.description,
      this.source,
      this.content,
      this.author,
      this.url,
      this.title,
      this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadNews(
                            content: this.content,
                            author: this.author,
                            imageUrl: this.urlToImage,
                            desc: this.description,
                            title: this.title,
                            url: this.url,
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: kPadding * 0.7),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('$urlToImage'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(kRoundedcornersradius)),
              width: 200.0,
              height: 125.0,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ReadNews.id);
            },
            child: Container(
                width: 200.0,
                child: Text(
                  '$title',
                  style: TextStyle(
                      height: 1.3, fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          Text(
            '$publishedAt',
            style: TextStyle(
                height: 1.5,
                color: Color(0xff666666),
                fontWeight: FontWeight.w500),
          ),
          Text(
            '$author',
            style: TextStyle(
                height: 1.5,
                color: Color(0xff666666),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
