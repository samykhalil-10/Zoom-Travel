part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeCarouselIndexState extends HomeState {}

class ChangeFavState extends HomeState {}

///Search
class SearchActivityLoading extends HomeState {}

class SearchActivitySuccess extends HomeState {}

class SearchActivityError extends HomeState {}

///Popular Activities

class GetPopularLoadingState extends HomeState {}

class GetPopularSuccessState extends HomeState {}

class GetPopularErrorState extends HomeState {}

///Location Avtivities
class GetLocationActivitiesLoadingState extends HomeState {}

class GetLocationActivitiesSuccessState extends HomeState {}

class GetLocationActivitiesErrorState extends HomeState {}

///Categories Avtivities
class GetCategoryActivitiesLoadingState extends HomeState {}

class GetCategoryActivitiesSuccessState extends HomeState {}

class GetCategoryActivitiesErrorState extends HomeState {}

///Recommendations

class GetRecommendationsLoadingState extends HomeState {}

class GetRecommendationsSuccessState extends HomeState {}

class GetRecommendationsErrorState extends HomeState {}