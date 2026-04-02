import 'package:flutter/material.dart';
import '../../../components/Home/Slider.dart';
import '../../../components/Home/Category.dart';
import '../../../components/Home/Suggestion.dart';
import '../../../components/Home/Hot.dart';
import '../../../components/Home/MoreList.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'), centerTitle: true),
      body: ListView(
        children: [
          Slider(),
          Category(),
          Suggestion(),
          Hot(),
          Container(height: 400, child: MoreList()),
        ],
      ),
    );
  }
}
