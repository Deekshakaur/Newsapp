import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsapp/constants.dart';
import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';

class ReadNews extends StatefulWidget {
  static const id = 'read';
  final String imageUrl;
  final String name;
  final String title;
  final String desc;
  final String url;
  final String author;
  final String content;
  ReadNews(
      {@required this.content,
      @required this.imageUrl,
      @required this.name,
      @required this.title,
      @required this.author,
      @required this.url,
      @required this.desc});
  @override
  _ReadNewsState createState() => _ReadNewsState();
}

class _ReadNewsState extends State<ReadNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .55,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.4), BlendMode.darken),
                  image: NetworkImage('${widget.imageUrl}'),
                  fit: BoxFit.cover),
            ),
            padding: EdgeInsets.fromLTRB(
                kPadding * 1.5, kPadding * 2, kPadding * 1.5, kPadding * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRect(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kPadding / 2, horizontal: kPadding),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.3),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.5, sigmaY: 10.6),
                          child: Text(
                            '${widget.name}',
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
                        '${widget.title}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: kPadding),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.author}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kRoundedcornersradius),
                    topRight: Radius.circular(kRoundedcornersradius)),
                color: Colors.white),
            padding: EdgeInsets.symmetric(
                vertical: kPadding * 2, horizontal: kPadding * 1.5),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Description: ${widget.desc}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 0.0,
                      ),
                    ),
                    SizedBox(
                      height: kPadding * 2,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => launch(widget.url),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Read full news  '),
                          Icon(Icons.open_in_new_rounded)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
