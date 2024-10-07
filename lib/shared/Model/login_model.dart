class Login {
  String? accessToken;
  String? message;
  Content? content;

  Login({this.accessToken, this.message, this.content});

  Login.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    message = json['message'];
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;
  }
}

class Content {
  Owner? owner;
  Content({this.owner});

  Content.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }
}

class Owner {
  int? id;
  String? name;
  String? email;
  String? role;
  String? mediaUrl;

  Owner({this.id, this.name, this.email, this.role, this.mediaUrl});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    mediaUrl = json['media_url'];
  }
}
