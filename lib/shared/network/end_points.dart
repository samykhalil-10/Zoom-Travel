class ApiUrl {

  ///Live
 static const String baseUrl = "https://restaurant-app-2.onrender.com/api/";
 static const String baseUrlImage = "https://restaurant-app-2.onrender.com";
  ///Local
  // static const String baseUrl = "http://192.168.11.102:7000/api/";
  // static const String baseUrlImage = "http://192.168.11.102:7000";

  ///Recommender Local
  static const String recommend = "http://192.168.11.102:8005/activity/";

  ///Auth
  static const String login = "auth";
  static const String signUp = "auth/signup";
  static const String forgetPass = "auth/forget-password";
  static const String resetPass = "auth/reset-password";

  ///Profile
  static const String profile = "me";
  static const String profileImage = "me/image";

  ///Activities
  static const String activity = "activity";
  static const String allActivities = "activity/all";
  static const String activityImage = "activity/media/add";
  static const String activityGalary = "activity/media";
  static const String tripLocation = "trip/all";
  static const String bestDeals = "activity/best";
  static const String nearby = "activity/nearby";
  static const String latestActivity = "activity/latest";
  static const String popularActivity = "activity/popular";
  static const String activityLocation = "activity/location";

  ///Favourites
  static const String favourite = "wishlist";
  ///Gallery Images
  static const String galleryImages = "activity/media";



}
