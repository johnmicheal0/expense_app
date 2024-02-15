class SignUpModel {
  String? username;
  String? password;
  int? age;
  String? gender;

  SignUpModel({this.username, this.password, this.age, this.gender});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}
