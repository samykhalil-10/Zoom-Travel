class Profile {
  Profile({
    required this.accessToken,
    required this.statusCode,
    required this.message,
    required this.content,
  });
  late final String accessToken;
  late final int statusCode;
  late final String message;
  late final Content content;

  Profile.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    statusCode = json['status_code'];
    message = json['message'];
    content = Content.fromJson(json['content']);
  }

}

class Content {
  Content({
    required this.user,
  });
  late final User user;

  Content.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdOn,
    required this.mediaUrl,
    required this.dateOfBirth,
    required this.phoneNumber,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String role;
  late final String createdOn;
  late final String mediaUrl;
  late final String dateOfBirth;
  late final String phoneNumber;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??"";
    email = json['email']??"";
    role = json['role']??"";
    createdOn = json['created_on']??"";
    mediaUrl = json['media_url']??"";
    dateOfBirth = json['date_of_birth']??"";
    phoneNumber = json['phone_number']??"";
  }

}
