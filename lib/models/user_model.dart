class UserModel {
  String email = "";
  String imageUrl = "";
  String username = "";

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    imageUrl = json['image_url'] ?? "";
    username = json['username'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['username'] = username;
    return data;
  }
}