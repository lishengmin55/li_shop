import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:li_shop/stores/CartStore.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);

  final Color _primaryColor = Color(0xFF2196F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '购物车',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              cartStore.toggleEditMode();
            },
            child: Obx(
              () => Text(
                cartStore.isEditMode.value ? '完成' : '管理',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (cartStore.items.isEmpty) {
          return _buildEmpty();
        }
        return Column(
          children: [
            Expanded(child: _buildCartList()),
            _buildBottomBar(),
          ],
        );
      }),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            '购物车是空的',
            style: TextStyle(fontSize: 16, color: Colors.grey[400]),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              '去逛逛',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      itemCount: cartStore.items.length,
      itemBuilder: (context, index) {
        final item = cartStore.items[index];
        return _buildCartItem(item, index);
      },
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 勾选框
          GestureDetector(
            onTap: () => cartStore.toggleItem(item.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.checked ? _primaryColor : Colors.transparent,
                border: Border.all(
                  color: item.checked ? _primaryColor : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: item.checked
                  ? Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 12),
          // 商品图片
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: item.picture.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.picture,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 32,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: Colors.grey[300],
                    ),
                  ),
          ),
          SizedBox(width: 12),
          // 商品信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '¥${item.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    _buildQuantityControl(item),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => cartStore.updateQuantity(item.id, item.quantity - 1),
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Text(
                '−',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
          Container(
            width: 36,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Text(
              '${item.quantity}',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          GestureDetector(
            onTap: () => cartStore.updateQuantity(item.id, item.quantity + 1),
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Text(
                '+',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Obx(() {
          final isEditMode = cartStore.isEditMode.value;
          final allChecked =
              cartStore.items.isNotEmpty &&
              cartStore.items.every((i) => i.checked);
          final checkedCount = cartStore.items.where((i) => i.checked).length;
          final totalPrice = cartStore.items
              .where((i) => i.checked)
              .fold(
                0.0,
                (sum, i) =>
                    sum +
                    (double.tryParse(i.price.replaceAll('¥', '')) ?? 0) *
                        i.quantity,
              );

          return Row(
            children: [
              // 全选
              GestureDetector(
                onTap: () => cartStore.toggleAll(),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: allChecked ? _primaryColor : Colors.transparent,
                        border: Border.all(
                          color: allChecked ? _primaryColor : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: allChecked
                          ? Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '全选',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // 价格或删除
              if (isEditMode)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: checkedCount > 0
                            ? () => cartStore.removeChecked()
                            : null,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text('删除($checkedCount)'),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '合计: ',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        '¥${cartStore.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: checkedCount > 0 ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          disabledBackgroundColor: Colors.grey[300],
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          '结算($checkedCount)',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
