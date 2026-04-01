import 'package:flutter/material.dart';
import 'package:li_shop/pages/Account/index.dart';
import 'package:li_shop/pages/Cart/index.dart';
import 'package:li_shop/pages/Home/index.dart';
import 'package:li_shop/pages/Shape/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 当前选中的索引

  // 渲染四个导航
  final List<Map<String, String>> _tabList = [
    {
      'icon': 'lib/assets/home-outline.png',
      'title': '首页',
    },
    {
      'icon': 'lib/assets/shape-outline.png',
      'title': '分类'
    },
    {
      'icon': 'lib/assets/cart-outline.png',
      'title': '购物车'
    },
    {
      'icon': 'lib/assets/account-outline.png',
      'title': '我的'
    },
  ];

  // 页面列表（这里用简单的Text作为示例，你可以替换为实际页面）
  final List<Widget> _pages = [
    HomeView(),
    ShapeView(),
    CartView(),
    AccountView(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(  // 使用IndexedStack来管理页面切换
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 设置为固定类型，使图标大小一致
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _tabList.map((item) {
          return BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6), // 添加内边距控制图标大小
              child: Image.asset(
                item['icon']!,
                width: 24,  // 设置图标宽度
                height: 24, // 设置图标高度
                color: Colors.grey, // 默认状态颜色
              ),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                item['icon']!,
                width: 28,  // 激活状态稍大一些
                height: 28,
                color: Theme.of(context).primaryColor, // 激活状态颜色
              ),
            ),
            label: item['title']!,
          );
        }).toList(),
        selectedItemColor: Theme.of(context).primaryColor, // 选中项颜色
        unselectedItemColor: Colors.grey, // 未选中项颜色
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), // 选中文字样式
        unselectedLabelStyle: const TextStyle(fontSize: 12), // 未选中文字样式
        elevation: 10, // 底部导航栏阴影效果
      ),
    );
  }
}