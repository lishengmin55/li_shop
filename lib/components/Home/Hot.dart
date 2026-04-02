import 'package:flutter/material.dart';

class Hot extends StatefulWidget {
  Hot({Key? key}) : super(key: key);

  @override
  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {
  final List<Map<String, dynamic>> _hotProducts = [
    {
      'rank': 1,
      'title': '无线蓝牙耳机 降噪长续航',
      'price': '¥299',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Wireless%20bluetooth%20earphones%20product%20image&image_size=square',
    },
    {
      'rank': 2,
      'title': '智能手环 心率监测',
      'price': '¥199',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Fitness%20tracker%20smart%20band%20product%20image&image_size=square',
    },
    {
      'rank': 3,
      'title': '便携充电宝 20000mAh',
      'price': '¥129',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Power%20bank%20portable%20charger%20product%20image&image_size=square',
    },
    {
      'rank': 4,
      'title': '运动水杯 保温保冷',
      'price': '¥89',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Sports%20water%20bottle%20product%20image&image_size=square',
    },
    {
      'rank': 5,
      'title': '蓝牙音箱 便携防水',
      'price': '¥199',
      'image':
          'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Bluetooth%20speaker%20portable%20product%20image&image_size=square',
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
              '热门商品',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _hotProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        child: Text(
                          '${_hotProducts[index]['rank']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: index < 3 ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(_hotProducts[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _hotProducts[index]['title'],
                              style: TextStyle(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            Text(
                              _hotProducts[index]['price'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
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
