import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoom_travel/shared/Model/favourite_model.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/network/end_points.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  static FavouriteCubit get(context) => BlocProvider.of(context);

  Favourite? favourite;

  void getFavourites({
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(GetFavouriteLoading());
    DioHelper.getData(
      url: ApiUrl.favourite,
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        favourite = Favourite.fromJson(value.data);
        print(value.data);
        print("Favourites Get Successfully !");
      } else {
        onError!();
      }
      emit(GetFavouriteSuccess());
    }).catchError((e) {
      emit(GetFavouriteError());
      print(e.toString());
    });
  }

  void deleteFavourite({
    Function()? onError,
    Function()? onSuccess,
    required int activity_id,
  }) {
    emit(DeleteFavouriteLoading());
    DioHelper.deleteData(
      url: ApiUrl.favourite,
      query: {'activityId': activity_id},
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        print(value.data);
        print("Favourites deleted Successfully !");
        onSuccess!();
      } else {
        onError!();
      }
      emit(DeleteFavouriteSuccess());
    }).catchError((e) {
      emit(DeleteFavouriteError());
      print(e.toString());
    });
  }

  void addFavourite({
    required int activity_id,
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(AddFavouriteLoading());
    DioHelper.postData(
        url: ApiUrl.favourite,
        token: CacheHelper.getData(key: "token"),
        data: {"activityId": activity_id}).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Favourite added Successfully !");
        onSuccess!();
      }
      emit(AddFavouriteSuccess());
    }).catchError((e) {
      emit(AddFavouriteError());
      print(e.toString());
    });
  }

  bool fav = false;
  void changeFavState() {
    fav = !fav;
    emit(ChangeFavState());
  }
}
