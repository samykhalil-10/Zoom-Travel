part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class AddFavouriteSuccess extends FavouriteState {}

class AddFavouriteError extends FavouriteState {}

class AddFavouriteLoading extends FavouriteState {}

class DeleteFavouriteSuccess extends FavouriteState {}

class DeleteFavouriteError extends FavouriteState {}

class DeleteFavouriteLoading extends FavouriteState {}

class GetFavouriteSuccess extends FavouriteState {}

class GetFavouriteError extends FavouriteState {}

class GetFavouriteLoading extends FavouriteState {}
class ChangeFavState extends FavouriteState {}
