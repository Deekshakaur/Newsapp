import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/Screens/Home/home.dart';
import 'package:newsapp/constants.dart';
import 'package:provider/provider.dart';
import '../../Screens/ReadNews/readnews.dart';
import '../../data.dart';

class Search extends StatefulWidget {
  static const id = 'search';
  String newsType = '';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget newsBuilder(List<Article> article) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return BreakingNewsBuilder(
            author: article[position].author,
            title: article[position].title,
            publishedAt: article[position].publishedAt,
            source: article[position].source,
            urlToImage: article[position].urlToImage ??
                'https://s3.amazonaws.com/speedsport-news/speedsport-news/wp-content/uploads/2018/07/01082232/image-not-found.png',
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Article>(builder: (context, data, child) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: kPadding * 1.5),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: kPadding * 4,
                    // ),
                    Text(
                      'Discover',
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: kPadding / 2.5),
                    Text(
                      'News from all over the world',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: kPadding),
                      padding: EdgeInsets.symmetric(vertical: kPadding),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            fillColor: Color(0xffe6e6e6),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            hintText: "Search",
                            suffixIcon: Icon(
                              FontAwesomeIcons.slidersH,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    kRoundedcornersradius / 2)))),
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          Container(
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              indicatorColor: Colors.black,
                              tabs: [
                                Tab(
                                  text: 'Health',
                                ),
                                Tab(
                                  text: 'Lifestyle',
                                )
                              ],
                              labelStyle: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w900),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .55,
                            padding: EdgeInsets.symmetric(vertical: kPadding),
                            child: TabBarView(
                              children: [
                                Container(
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      return snapshot.data == null
                                          ? Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.black),
                                            ))
                                          : newsBuilder(snapshot.data);
                                    },
                                    future: data.getData(widget.newsType),
                                  ),
                                ),
                                Container(
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      return snapshot.data == null
                                          ? Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.black),
                                            ))
                                          : newsBuilder(snapshot.data);
                                    },
                                    future: data.getData(widget.newsType),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
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
    return GestureDetector(onTap: () {
      {
        Navigator.pop(
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
      }
      Container(
        height: MediaQuery.of(context).size.height * .55,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: kPadding, right: kPadding * 0.7),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(urlToImage), fit: BoxFit.cover),
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(kRoundedcornersradius / 2)),
              width: kPadding * 5,
              height: kPadding * 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        height: 1.3,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: kPadding / 2.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 14.0,
                            color: Colors.grey,
                          ),
                          Text(
                            author,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 14.0,
                            color: Colors.grey,
                          ),
                          Text(
                            publishedAt,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
