import 'package:flutter/material.dart';
import 'package:li_shop/viewmodels/home.dart';
import '../../../components/Home/HomeSlider.dart';
import '../../../components/Home/Category.dart';
import '../../../components/Home/Suggestion.dart';
import '../../../components/Home/Hot.dart';
import '../../../components/Home/MoreList.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _banners = [];

  @override
  void initState() {
    super.initState();
    _banners = [
      BannerItem(id: '1', imgUrl: 'lib/assets/屏幕截图 2026-04-01 211528.png'),
      BannerItem(id: '2', imgUrl: 'lib/assets/屏幕截图 2026-04-01 211540.png'),
      BannerItem(id: '3', imgUrl: 'lib/assets/屏幕截图 2026-04-01 211550.png'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false, // 隐藏默认返回按钮
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索商品...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 16),
              ),
            ),
          ),
          toolbarHeight: 50,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HomeSlider(banners: _banners)),
          SliverToBoxAdapter(child: Category()),
          SliverToBoxAdapter(child: Suggestion()),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '热门商品',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Hot(title: '热门1'),
                      const SizedBox(width: 10),
                      Hot(title: '热门2'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Hot(title: '热门3'),
                      const SizedBox(width: 10),
                      Hot(title: '热门4'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '更多商品',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [MoreList(title: '更多1')],
                      ),
                      const SizedBox(height: 20),
                      Flex(
                        direction: Axis.horizontal,
                        children: [MoreList(title: '更多3')],
                      ),
                      const SizedBox(height: 20),
                      Flex(
                        direction: Axis.horizontal,
                        children: [MoreList(title: '更多4')],
                      ),
                      const SizedBox(height: 20),
                      Flex(
                        direction: Axis.horizontal,
                        children: [MoreList(title: '更多5')],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
