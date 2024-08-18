class AuthModel {
  String? message;
  String? token;

  AuthModel({this.message, this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    message: json['message'] as String?,
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'Token': token,
  };
}
