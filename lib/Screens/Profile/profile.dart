import 'package:flutter/material.dart';
import 'package:newsapp/data.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const id = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Article>(
      builder: (context, data, child) {
        return SafeArea(
          child: Scaffold(
            body: Center(),
          ),
        );
      },
    );
  }
}
