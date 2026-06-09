import 'package:flutter/material.dart';
import 'package:li_shop/viewmodels/home.dart';

class ShapeView extends StatefulWidget {
  ShapeView({Key? key}) : super(key: key);

  @override
  _ShapeViewState createState() => _ShapeViewState();
}

class _ShapeViewState extends State<ShapeView> {
  int _selectedIndex = 0;

  // 本地模拟分类数据
  final List<CategoryItem> _categories = [
    CategoryItem(
      id: '1',
      name: '手机',
      picture: '',
      children: [
        CategoryItem(id: '101', name: '全面屏手机', picture: ''),
        CategoryItem(id: '102', name: '游戏手机', picture: ''),
        CategoryItem(id: '103', name: '拍照手机', picture: ''),
        CategoryItem(id: '104', name: '老人手机', picture: ''),
        CategoryItem(id: '105', name: '对讲机', picture: ''),
        CategoryItem(id: '106', name: '手机配件', picture: ''),
      ],
    ),
    CategoryItem(
      id: '2',
      name: '电脑',
      picture: '',
      children: [
        CategoryItem(id: '201', name: '笔记本', picture: ''),
        CategoryItem(id: '202', name: '台式机', picture: ''),
        CategoryItem(id: '203', name: '游戏本', picture: ''),
        CategoryItem(id: '204', name: '轻薄本', picture: ''),
        CategoryItem(id: '205', name: '一体机', picture: ''),
        CategoryItem(id: '206', name: '服务器', picture: ''),
      ],
    ),
    CategoryItem(
      id: '3',
      name: '平板',
      picture: '',
      children: [
        CategoryItem(id: '301', name: 'iPad', picture: ''),
        CategoryItem(id: '302', name: '安卓平板', picture: ''),
        CategoryItem(id: '303', name: 'Windows平板', picture: ''),
        CategoryItem(id: '304', name: '学习平板', picture: ''),
      ],
    ),
    CategoryItem(
      id: '4',
      name: '家电',
      picture: '',
      children: [
        CategoryItem(id: '401', name: '电视', picture: ''),
        CategoryItem(id: '402', name: '空调', picture: ''),
        CategoryItem(id: '403', name: '洗衣机', picture: ''),
        CategoryItem(id: '404', name: '冰箱', picture: ''),
        CategoryItem(id: '405', name: '热水器', picture: ''),
        CategoryItem(id: '406', name: '油烟机', picture: ''),
      ],
    ),
    CategoryItem(
      id: '5',
      name: '服饰',
      picture: '',
      children: [
        CategoryItem(id: '501', name: '男装', picture: ''),
        CategoryItem(id: '502', name: '女装', picture: ''),
        CategoryItem(id: '503', name: '童装', picture: ''),
        CategoryItem(id: '504', name: '内衣', picture: ''),
        CategoryItem(id: '505', name: '运动装', picture: ''),
      ],
    ),
    CategoryItem(
      id: '6',
      name: '美妆',
      picture: '',
      children: [
        CategoryItem(id: '601', name: '护肤', picture: ''),
        CategoryItem(id: '602', name: '彩妆', picture: ''),
        CategoryItem(id: '603', name: '香水', picture: ''),
        CategoryItem(id: '604', name: '美发', picture: ''),
      ],
    ),
    CategoryItem(
      id: '7',
      name: '食品',
      picture: '',
      children: [
        CategoryItem(id: '701', name: '零食', picture: ''),
        CategoryItem(id: '702', name: '饮料', picture: ''),
        CategoryItem(id: '703', name: '生鲜', picture: ''),
        CategoryItem(id: '704', name: '粮油', picture: ''),
        CategoryItem(id: '705', name: '酒水', picture: ''),
      ],
    ),
    CategoryItem(
      id: '8',
      name: '家居',
      picture: '',
      children: [
        CategoryItem(id: '801', name: '家具', picture: ''),
        CategoryItem(id: '802', name: '灯饰', picture: ''),
        CategoryItem(id: '803', name: '家纺', picture: ''),
        CategoryItem(id: '804', name: '厨具', picture: ''),
      ],
    ),
    CategoryItem(
      id: '9',
      name: '运动',
      picture: '',
      children: [
        CategoryItem(id: '901', name: '跑步鞋', picture: ''),
        CategoryItem(id: '902', name: '健身器材', picture: ''),
        CategoryItem(id: '903', name: '瑜伽', picture: ''),
        CategoryItem(id: '904', name: '球类', picture: ''),
      ],
    ),
    CategoryItem(
      id: '10',
      name: '图书',
      picture: '',
      children: [
        CategoryItem(id: '1001', name: '文学', picture: ''),
        CategoryItem(id: '1002', name: '教育', picture: ''),
        CategoryItem(id: '1003', name: '科技', picture: ''),
        CategoryItem(id: '1004', name: '童书', picture: ''),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          _buildLeftPanel(),
          Expanded(child: _buildRightPanel()),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      width: 90,
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color:
                        isSelected ? Color(0xFF2196F3) : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                _categories[index].name,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Color(0xFF2196F3) : Colors.black54,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRightPanel() {
    final category = _categories[_selectedIndex];
    final children = category.children ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              category.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          if (children.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text('暂无子分类',
                    style: TextStyle(color: Colors.grey[400])),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) {
                return _buildSubCategory(children[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSubCategory(CategoryItem item) {
    return GestureDetector(
      onTap: () {
        // TODO: 跳转商品列表页
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(Icons.category_outlined,
                    size: 32, color: Colors.grey[300]),
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            item.name,
            style: TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
