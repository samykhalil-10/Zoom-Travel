class Favourite {
  String? message;
  Content? content;

  Favourite({this.message, this.content});

  Favourite.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;
  }
}

class Content {
  List<Wishlist>? wishlist;

  Content({this.wishlist});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }
}

class Wishlist {
  int? aId;
  String? aName;
  String? aDescription;
  String? displayImage;
  bool? isFav;

  Wishlist({this.aId, this.aName, this.aDescription, this.isFav, this.displayImage});

  Wishlist.fromJson(Map<String, dynamic> json) {
    aId = json['id'];
    aName = json['name'];
    aDescription = json['description'];
    displayImage = json['display_image'];
    isFav = json['is_favorite'];
  }
}
