import 'package:flutter/material.dart';
import 'package:li_shop/api/home.dart';
import 'package:li_shop/viewmodels/home.dart';
import '../../../components/Home/HomeSlider.dart'
    show HomeSlider, getDefaultBanners;
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

  List<GoodDetailItem> _recommend = [];

  final ScrollController _scrollController = ScrollController();

  int _limit = 20;

  bool _isLoadingMore = false;

  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadBanners();
    _loadCategories();
    _loadSuggestion();
    _loadInVogue();
    _loadOneStop();
    _loadRecommend();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 滚动监听器：检测是否滚动到页面底部
  /// 当滚动位置距离底部100像素以内时，触发加载更多
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (!_isLoadingMore && _hasMore) {
        _loadMoreRecommend();
      }
    }
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

  /// 初始加载推荐列表
  /// 使用当前的 _limit 值作为请求参数
  Future<void> _loadRecommend() async {
    try {
      final recommend = await getRecommend(param: {'limit': _limit});
      setState(() {
        _recommend = recommend;
      });
    } catch (error) {
      print('获取推荐列表失败: $error');
    }
  }

  /// 加载更多推荐列表
  /// 每次调用时 limit 增加 10，实现分页加载效果
  ///
  /// 流程说明：
  /// 1. 检查是否正在加载或没有更多数据，如果是则直接返回
  /// 2. 设置 _isLoadingMore 为 true，显示加载指示器
  /// 3. 将 _limit 增加 10
  /// 4. 发起网络请求获取新的数据
  /// 5. 如果返回数据为空，设置 _hasMore 为 false
  /// 6. 如果请求失败，回滚 _limit 值
  Future<void> _loadMoreRecommend() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      _limit += 10;
      final newRecommend = await getRecommend(param: {'limit': _limit});

      setState(() {
        if (newRecommend.isEmpty) {
          _hasMore = false;
        } else {
          _recommend = newRecommend;
        }
        _isLoadingMore = false;
      });
    } catch (error) {
      print('加载更多推荐列表失败: $error');
      setState(() {
        _isLoadingMore = false;
        _limit -= 10;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
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
        controller: _scrollController,
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
          SliverToBoxAdapter(child: MoreList(recommendList: _recommend)),
          if (_isLoadingMore)
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          if (!_hasMore)
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text('没有更多数据了', style: TextStyle(color: Colors.grey)),
              ),
            ),
        ],
      ),
    );
  }
}
