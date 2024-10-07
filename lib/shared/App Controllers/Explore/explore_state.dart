part of 'explore_cubit.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

///Newest Activities
class GetNewLoadingState extends ExploreState {}
class GetNewSuccessState extends ExploreState {}
class GetNewErrorState extends ExploreState {}

///NearBy Activities
class GetNearByLoadingState extends ExploreState {}
class GetNearBySuccessState extends ExploreState {}
class GetNearByErrorState extends ExploreState {}

///Best Deals Activities
class GetBestLoadingState extends ExploreState {}
class GetBestSuccessState extends ExploreState {}
class GetBestErrorState extends ExploreState {}
