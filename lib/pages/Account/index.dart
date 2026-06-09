import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:li_shop/pages/Login/index.dart';
import 'package:li_shop/stores/UserStore.dart';

class AccountView extends StatelessWidget {
  AccountView({Key? key}) : super(key: key);

  final Color _primaryColor = Color.fromARGB(255, 237, 7, 7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _buildUserHeader(),
            SizedBox(height: 12),
            _buildOrderSection(),
            SizedBox(height: 12),
            _buildMenuList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        final isLoggedIn = userStore.isLoggedIn;
        final user = userStore.user;
        return Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
                border: Border.all(
                  color: _primaryColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: isLoggedIn
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: user?.avator.isNotEmpty ?? false
                          ? Image.network(
                              user!.avator,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 32,
                                  color: _primaryColor,
                                );
                              },
                            )
                          : Icon(Icons.person, size: 32, color: _primaryColor),
                    )
                  : Icon(
                      Icons.person_outline,
                      size: 32,
                      color: Colors.grey[400],
                    ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLoggedIn
                        ? (user?.nickname.isNotEmpty ?? false
                              ? user!.nickname
                              : user!.account)
                        : 'Hi，欢迎来到商城',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    isLoggedIn ? '欢迎回来' : '登录享受更多权益',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            isLoggedIn ? _buildLogoutButton() : _buildLoginButton(),
          ],
        );
      }),
    );
  }

  Widget _buildLoginButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(LoginPage());
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '立即登录',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.dialog(
            AlertDialog(
              title: Text('提示'),
              content: Text('确定要退出登录吗？'),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('取消')),
                TextButton(
                  onPressed: () {
                    Get.back();
                    userStore.logout();
                  },
                  child: Text('确定', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '退出登录',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSection() {
    final orderItems = [
      {'icon': Icons.list_alt, 'label': '全部'},
      {'icon': Icons.payment_outlined, 'label': '待付款'},
      {'icon': Icons.inventory_2_outlined, 'label': '待发货'},
      {'icon': Icons.local_shipping_outlined, 'label': '待收货'},
      {'icon': Icons.star_border, 'label': '待评价'},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '我的订单',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    '查看全部',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: Colors.grey[400]),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: orderItems.map((item) {
              return _buildOrderItem(
                icon: item['icon'] as IconData,
                label: item['label'] as String,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({required IconData icon, required String label}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: _primaryColor),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    final menuItems = [
      {'icon': Icons.favorite_border, 'label': '我的收藏', 'count': '0'},
      {'icon': Icons.history, 'label': '我的足迹', 'count': '0'},
      {'icon': Icons.headset_mic_outlined, 'label': '在线客服', 'count': null},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Text(
                  '我的服务',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          ...menuItems.map((item) {
            return _buildMenuItem(
              icon: item['icon'] as IconData,
              label: item['label'] as String,
              count: item['count'] as String?,
              isLast: item == menuItems.last,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    String? count,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: Colors.grey[100]!, width: 1)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: _primaryColor),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            if (count != null)
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  count,
                  style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                ),
              ),
            Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
