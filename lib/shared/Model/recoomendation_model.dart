class Recommendation {
  Recommendation({
    required this.recommendations,
  });
  late final List<Recommendations> recommendations;

  Recommendation.fromJson(Map<String, dynamic> json){
    recommendations = List.from(json['recommendations']).map((e)=>Recommendations.fromJson(e)).toList();
  }
}

class Recommendations {
  Recommendations({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
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
  late final Category category;
  late final double lat;
  late final double lng;
  late final String createdOn;
  late final String redirectUrl;
  late final bool isFavorite;
  late final String displayImage;
  late final int rating;

  Recommendations.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = Category.fromJson(json['category']);
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

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    createdOn = json['created_on'];
  }
}