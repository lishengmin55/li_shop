import 'package:flutter/material.dart';

class ShapeView extends StatefulWidget {
  ShapeView({Key? key}) : super(key: key);

  @override
  _ShapeViewState createState() => _ShapeViewState();
}

class _ShapeViewState extends State<ShapeView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('种类'));
  }
}