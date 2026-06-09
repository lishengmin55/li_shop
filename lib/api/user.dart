import 'package:li_shop/constants/index.dart';
import 'package:li_shop/utils/DioRequest.dart';
import 'package:li_shop/viewmodels/user.dart';

Future<User> login({required String account, required String password}) async {
  final result = await dioRequest.post(
    HttpConstants.LOGIN,
    data: {'account': account, 'password': password},
  );
  return User.fromJson(result);
}

Future<User> register({
  required String account,
  required String password,
}) async {
  final result = await dioRequest.post(
    HttpConstants.REGISTER,
    data: {'account': account, 'password': password},
  );
  return User.fromJson(result);
}
