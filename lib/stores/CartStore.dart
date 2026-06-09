import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final String price;
  final String picture;
  int quantity;
  bool checked;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    this.quantity = 1,
    this.checked = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'picture': picture,
        'quantity': quantity,
        'checked': checked,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        price: json['price'] ?? '0.00',
        picture: json['picture'] ?? '',
        quantity: json['quantity'] ?? 1,
        checked: json['checked'] ?? false,
      );
}

class CartStore extends GetxController {
  final _items = <CartItem>[].obs;
  final _isEditMode = false.obs;

  static const String _cartKey = 'cart_items';

  List<CartItem> get items => _items;
  RxList<CartItem> get itemsRx => _items;
  RxBool get isEditMode => _isEditMode;

  double get totalPrice {
    return _items
        .where((i) => i.checked)
        .fold(0.0, (sum, i) {
          final price = double.tryParse(i.price.replaceAll('¥', '')) ?? 0;
          return sum + price * i.quantity;
        });
  }

  @override
  void onInit() {
    super.onInit();
    _loadFromLocal();
  }

  Future<void> _loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_cartKey);
    if (jsonStr != null) {
      try {
        final List<dynamic> list = jsonDecode(jsonStr);
        _items.value = list.map((e) => CartItem.fromJson(e)).toList();
      } catch (_) {}
    }
  }

  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(_items.map((e) => e.toJson()).toList());
    await prefs.setString(_cartKey, jsonStr);
  }

  void addItem(CartItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(item);
    }
    _items.refresh();
    _saveToLocal();
  }

  void removeItem(String id) {
    _items.removeWhere((i) => i.id == id);
    _saveToLocal();
  }

  void removeChecked() {
    _items.removeWhere((i) => i.checked);
    _saveToLocal();
  }

  void toggleItem(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _items[index].checked = !_items[index].checked;
      _items.refresh();
      _saveToLocal();
    }
  }

  void toggleAll() {
    final allChecked = _items.every((i) => i.checked);
    for (var item in _items) {
      item.checked = !allChecked;
    }
    _items.refresh();
    _saveToLocal();
  }

  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      _items.refresh();
      _saveToLocal();
    }
  }

  void toggleEditMode() {
    _isEditMode.value = !_isEditMode.value;
  }

  void clear() {
    _items.clear();
    _saveToLocal();
  }
}

final cartStore = CartStore();
