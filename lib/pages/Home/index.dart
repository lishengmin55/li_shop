import 'package:flutter/material.dart';
import 'package:li_shop/api/home.dart';
import 'package:li_shop/viewmodels/home.dart';
import '../../../components/Home/HomeSlider.dart'
    show HomeSlider, getDefaultBanners;
import '../../../components/Home/Category.dart';
import '../../../components/Home/Suggestion.dart';
import '../../../components/Home/Hot.dart' ;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _banners = [];
  List<CategoryItem> _categories = [];
  HomeRecommendResult _suggestion = HomeRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  HomeRecommendResult _inVogue = HomeRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  HomeRecommendResult _oneStop = HomeRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBanners();
    _loadCategories();
    _loadSuggestion();
    _loadInVogue();
    _loadOneStop();
  }

  Future<void> _loadBanners() async {
    try {
      final banners = await getBannerList();
      setState(() {
        _banners = banners;
        _isLoading = false;
      });
    } catch (error) {
      print('获取轮播图失败: $error');
      // 使用默认数据
      setState(() {
        _banners = getDefaultBanners();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await getCategoryList();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (error) {
      print('获取分类失败: $error');
      // 使用默认数据
      setState(() {
        _categories = [];
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSuggestion() async {
    try {
      final suggestion = await getHomeRecommend();
      setState(() {
        _suggestion = suggestion;
        _isLoading = false;
      });
    } catch (error) {
      print('获取热门商品失败: $error');
      setState(() {});
    }
  }

  Future<void> _loadInVogue() async {
    try {
      final inVogue = await getInVogueList();
      setState(() {
        _inVogue = inVogue;
      });
    } catch (error) {
      print('获取爆款推荐失败: $error');
    }
  }

  Future<void> _loadOneStop() async {
    try {
      final oneStop = await getOneStopList();
      setState(() {
        _oneStop = oneStop;
      });
    } catch (error) {
      print('获取一站买全失败: $error');
    }
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
          SliverToBoxAdapter(
            child: _isLoading
                ? Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : HomeSlider(banners: _banners),
          ),
          SliverToBoxAdapter(child: Category(categories: _categories)),
          SliverToBoxAdapter(child: Suggestion(suggestion: _suggestion)),
          SliverToBoxAdapter(
            child: Hot(inVogue: _inVogue, oneStop: _oneStop),
          ),
        ],
      ),
    );
  }
}
