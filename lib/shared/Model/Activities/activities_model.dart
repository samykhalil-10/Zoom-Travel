class GeneralActivities {
  GeneralActivities({
    required this.content,
  });

  late final Content content;

  GeneralActivities.fromJson(Map<String, dynamic> json) {
    content = Content.fromJson(json['content']);
  }
}

class Content {
  Content({
    required this.activities,
  });

  late final List<Activities> activities;

  Content.fromJson(Map<String, dynamic> json) {
    activities = List.from(json['activities'])
        .map((e) => Activities.fromJson(e))
        .toList();
  }
}

class Activities {
  Activities({
    required this.id,
    required this.name,
    required this.description,
    this.category,
    required this.lat,
    required this.lng,
    required this.createdOn,
    required this.redirectUrl,
    required this.isFavorite,
    required this.displayImage,
    required this.rating,
  });

  late final int id;
  late final String name;
  late final String description;
  late final Category? category;
  late final double? lat;
  late final double? lng;
  late final String createdOn;
  late final String redirectUrl;
  late final bool isFavorite;
  late final String displayImage;
  late final int rating;

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = null;
    lat = json['lat'];
    lng = json['lng'];
    createdOn = json['created_on'];
    redirectUrl = json['redirect_url'];
    isFavorite = json['is_favorite'];
    displayImage = json['display_image'];
    rating = json['rating'];
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.createdOn,
  });

  late final int id;
  late final String name;
  late final String createdOn;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdOn = json['created_on'];
  }
}
