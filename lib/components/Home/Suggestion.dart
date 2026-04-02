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
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Smartphone%20product%20image&image_size=square',
    },
    {
      'title': '笔记本电脑',
      'price': '¥5999',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Laptop%20computer%20product%20image&image_size=square',
    },
    {
      'title': '无线耳机',
      'price': '¥899',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Wireless%20earbuds%20product%20image&image_size=square',
    },
    {
      'title': '智能手表',
      'price': '¥1299',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Smart%20watch%20product%20image&image_size=square',
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
                          image: DecorationImage(
                            image: NetworkImage(_suggestions[index]['image']),
                            fit: BoxFit.cover,
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
