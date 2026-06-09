class User {
  final String account;
  final String avator;
  final String birthday;
  final String cityCode;
  final String gender;
  final String id;
  final String mobile;
  final String nickname;
  final String profession;
  final String proviceCode;
  final String token;

  User({
    this.id = '',
    this.account = '',
    this.nickname = '',
    this.avator = '',
    this.birthday = '',
    this.cityCode = '',
    this.gender = '',
    this.mobile = '',
    this.profession = '',
    this.proviceCode = '',
    this.token = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      account: json['account']?.toString() ?? '',
      nickname: json['nickname']?.toString() ?? '',
      avator: json['avator']?.toString() ?? '',
      birthday: json['birthday']?.toString() ?? '',
      cityCode: json['cityCode']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      profession: json['profession']?.toString() ?? '',
      proviceCode: json['proviceCode']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account': account,
      'nickname': nickname,
      'avator': avator,
      'birthday': birthday,
      'cityCode': cityCode,
      'gender': gender,
      'mobile': mobile,
      'profession': profession,
      'proviceCode': proviceCode,
      'token': token,
    };
  }

  bool isLoggedIn() {
    return token.isNotEmpty && id.isNotEmpty;
  }
}
