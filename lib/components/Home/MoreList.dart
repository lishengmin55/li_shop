import 'package:flutter/material.dart';

class MoreList extends StatefulWidget {
  MoreList({Key? key}) : super(key: key);

  @override
  _MoreListState createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {
  final List<Map<String, dynamic>> _products = [
    {
      'title': '纯棉T恤 舒适透气',
      'price': '¥99',
      'color': Colors.blue.shade100,
      'icon': Icons.checkroom,
    },
    {
      'title': '牛仔裤 修身版型',
      'price': '¥199',
      'color': Colors.grey.shade200,
      'icon': Icons.style,
    },
    {
      'title': '运动鞋 轻便舒适',
      'price': '¥299',
      'color': Colors.orange.shade100,
      'icon': Icons.directions_run,
    },
    {
      'title': '休闲外套 时尚百搭',
      'price': '¥399',
      'color': Colors.purple.shade100,
      'icon': Icons.shopping_bag,
    },
  ];

  bool _isLoading = false;

  Future<void> _refreshProducts() async {
    // 模拟网络请求
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // 刷新数据
    });
  }

  void _loadMore() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    // 模拟网络请求
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      // 加载更多数据
    });
  }

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
              '更多商品',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshProducts,
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _loadMore();
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: _products.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _products.length) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: _products[index]['color'],
                            ),
                            child: Center(
                              child: Icon(
                                _products[index]['icon'],
                                size: 40,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _products[index]['title'],
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _products[index]['price'],
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
            ),
          ),
        ],
      ),
    );
  }
}
