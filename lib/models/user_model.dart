class UserModel {
  String email = "";
  String imageUrl = "";
  String username = "";
  String userType = "";

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    imageUrl = json['image_url'] ?? "";
    username = json['username'] ?? "";
    userType = json['userType'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['username'] = username;
    data['userType'] = userType;
    return data;
  }
}