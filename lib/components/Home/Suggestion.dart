import 'package:flutter/material.dart';

class Suggestion extends StatefulWidget {
  Suggestion({Key? key}) : super(key: key);

  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  final List<Map<String, dynamic>> _suggestions = [
    {
      'title': '智能手机',
      'price': '¥3999',
      'color': Colors.blue.shade100,
      'icon': Icons.phone_android,
    },
    {
      'title': '笔记本电脑',
      'price': '¥5999',
      'color': Colors.purple.shade100,
      'icon': Icons.laptop,
    },
    {
      'title': '无线耳机',
      'price': '¥899',
      'color': Colors.green.shade100,
      'icon': Icons.headphones,
    },
    {
      'title': '智能手表',
      'price': '¥1299',
      'color': Colors.orange.shade100,
      'icon': Icons.watch,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '为你推荐',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _suggestions[index]['color'],
                        ),
                        child: Center(
                          child: Icon(
                            _suggestions[index]['icon'],
                            size: 50,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _suggestions[index]['title'],
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        _suggestions[index]['price'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
