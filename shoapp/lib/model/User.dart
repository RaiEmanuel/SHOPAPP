class User {
  int id = 0;
  String name = "default name";
  String picture = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AUser-avatar.svg&psig=AOvVaw3BwmOhz_6hDY7nDc1MLXOE&ust=1636125147669000&source=images&cd=vfe&ved=0CAgQjRxqFwoTCNilhKb__vMCFQAAAAAdAAAAABAD";
  String email = "default@gmail.com";

  Credential ? credential ;

  User({required this.id, required this.name, required this.picture, required this.email, required this.credential});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
    email = json['email'];
    credential = json['credential'] != null
        ? new Credential.fromJson(json['credential'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['email'] = this.email;
    if (this.credential != null) {
      data['credential'] = this.credential!.toJson();
    }
    return data;
  }
}

class Credential {
  String ? type = null;
  String ? token = null;

  Credential({required this.type, required this.token});

  Credential.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['token'] = this.token;
    return data;
  }
}