import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:li_shop/stores/UserStore.dart';
import 'package:li_shop/pages/Register/index.dart';
import 'package:li_shop/pages/Main/index.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color _primaryColor = Color(0xFF2196F3);
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  String? _accountError;
  String? _passwordError;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validatePhone(String phone) {
    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    return phoneRegex.hasMatch(phone);
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool _validateForm() {
    String account = _accountController.text.trim();
    String password = _passwordController.text;

    setState(() {
      _accountError = null;
      _passwordError = null;
    });

    bool isValid = true;

    if (account.isEmpty) {
      setState(() {
        _accountError = '请输入手机号或邮箱';
      });
      isValid = false;
    } else if (!_validatePhone(account) && !_validateEmail(account)) {
      setState(() {
        _accountError = '请输入正确的手机号或邮箱格式';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = '请输入密码';
      });
      isValid = false;
    } else if (password.length < 6) {
      setState(() {
        _passwordError = '密码长度不能少于6位';
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> _handleLogin() async {
    if (!_validateForm()) return;

    setState(() {
      _isLoading = true;
    });

    final success = await userStore.login(
      _accountController.text.trim(),
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _showSuccessMessage(context);
    } else {
      final error = userStore.error ?? '登录失败';
      _handleLoginError(error);
    }
  }

  void _handleLoginError(String error) {
    setState(() {
      _accountError = null;
      _passwordError = null;
    });

    if (error.contains('账号不存在')) {
      setState(() {
        _accountError = '账号不存在';
      });
    } else if (error.contains('密码错误')) {
      setState(() {
        _passwordError = '密码错误';
      });
    } else if (error.contains('账号') ||
        error.contains('用户') ||
        error.contains('不存在')) {
      setState(() {
        _accountError = error;
      });
    } else if (error.contains('密码') || error.contains('错误')) {
      setState(() {
        _passwordError = error;
      });
    } else {
      _showErrorMessage(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildBackButton(context),
              SizedBox(height: 30),
              _buildTitle(),
              SizedBox(height: 48),
              _buildAccountInput(),
              SizedBox(height: 16),
              _buildPasswordInput(),
              SizedBox(height: 8),
              _buildForgotPassword(),
              SizedBox(height: 32),
              _buildLoginButton(),
              SizedBox(height: 40),
              _buildDivider(),
              SizedBox(height: 32),
              _buildThirdPartyLogin(),
              SizedBox(height: 48),
              _buildRegisterLink(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        '账号登录',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAccountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _accountError != null ? Colors.red : Colors.grey[200]!,
            ),
          ),
          child: TextField(
            controller: _accountController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: '请输入手机号/邮箱',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.grey[400],
                size: 22,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onChanged: (value) {
              if (_accountError != null) {
                setState(() {
                  _accountError = null;
                });
              }
            },
          ),
        ),
        if (_accountError != null)
          Padding(
            padding: EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _accountError!,
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _passwordError != null ? Colors.red : Colors.grey[200]!,
            ),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: '请输入密码',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.grey[400],
                size: 22,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey[400],
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onChanged: (value) {
              if (_passwordError != null) {
                setState(() {
                  _passwordError = null;
                });
              }
            },
          ),
        ),
        if (_passwordError != null)
          Padding(
            padding: EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _passwordError!,
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          '忘记密码？',
          style: TextStyle(fontSize: 13, color: _primaryColor),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _handleLogin,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    '登录',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Text(
                '登录成功',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
    Future.delayed(Duration(milliseconds: 500), () {
      Get.back();
      Get.offAll(() => MainPage());
    });
  }

  void _showErrorMessage(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[200])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '其他登录方式',
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[200])),
      ],
    );
  }

  Widget _buildThirdPartyLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: _buildThirdPartyButton(
              icon: Icons.chat,
              color: Color(0xFF07C160),
              onTap: () {},
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: _buildThirdPartyButton(
              icon: Icons.chat_bubble,
              color: Color(0xFF12B7F5),
              onTap: () {},
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: _buildThirdPartyButton(
              icon: Icons.apple,
              color: Colors.black,
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThirdPartyButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.to(RegisterPage());
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            children: [
              TextSpan(text: '还没有账号？'),
              TextSpan(
                text: '立即注册',
                style: TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
