import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<Map<String, dynamic>> _categories = [
    {'name': '手机', 'icon': Icons.phone_android},
    {'name': '电脑', 'icon': Icons.laptop},
    {'name': '服装', 'icon': Icons.checkroom},
    {'name': '食品', 'icon': Icons.restaurant},
    {'name': '家电', 'icon': Icons.tv},
    {'name': '美妆', 'icon': Icons.face},
    {'name': '图书', 'icon': Icons.book},
    {'name': '更多', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  _categories[index]['icon'],
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(_categories[index]['name'], style: TextStyle(fontSize: 12)),
            ],
          );
        },
      ),
    );
  }
}
