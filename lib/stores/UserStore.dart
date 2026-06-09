import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:li_shop/viewmodels/user.dart';
import 'package:li_shop/api/user.dart' as userApi;

class UserStore extends GetxController {
  final _user = Rx<User?>(null);
  final _isLoading = false.obs;
  final _error = Rx<String?>(null);

  User? get user => _user.value;
  bool get isLoggedIn => _user.value?.isLoggedIn() ?? false;
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;

  static const String _userKey = 'current_user';
  static const String _tokenKey = 'user_token';

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        final Map<String, dynamic> userData = jsonDecode(userJson);
        _user.value = User.fromJson(userData);
      } catch (e) {
        _user.value = null;
      }
    }
  }

  Future<bool> login(String account, String password) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      _user.value = await userApi.login(account: account, password: password);
      await _saveUser();
      _isLoading.value = false;
      return true;
    } catch (e) {
      _isLoading.value = false;
      _error.value = e.toString().replaceAll('Exception: ', '');
      return false;
    }
  }

  Future<bool> register(String account, String password) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      _user.value = await userApi.register(
        account: account,
        password: password,
      );
      await _saveUser();
      _isLoading.value = false;
      return true;
    } catch (e) {
      _isLoading.value = false;
      _error.value = e.toString().replaceAll('Exception: ', '');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
    _user.value = null;
  }

  Future<void> _saveUser() async {
    if (_user.value != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(_user.value!.toJson()));
      if (_user.value!.token.isNotEmpty) {
        await prefs.setString(_tokenKey, _user.value!.token);
      }
    }
  }

  void clearError() {
    _error.value = null;
  }
}

UserStore get userStore => Get.find<UserStore>();
