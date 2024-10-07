import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoom_travel/shared/Model/Activities/activities_model.dart';
import 'package:zoom_travel/shared/Model/gallary_model.dart';
import 'package:zoom_travel/shared/Model/recoomendation_model.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/network/end_points.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int carouselIndex = 0;

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    emit(ChangeCarouselIndexState());
  }

  GeneralActivities? generalActivities;
  Gallary? gallery;
  List<Activities> searchList = [];

  void searchActivity({required String searchKey}) {
    emit(SearchActivityLoading());
    DioHelper.getData(
        url: ApiUrl.activity,
        token: token,
        query: {'search': searchKey}).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        searchList = generalActivities!.content.activities;
        print('This Data : ${value.data}');
        print('Search Result Get Done');
      }
      emit(SearchActivitySuccess());
    }).catchError((onError) {
      emit(SearchActivityError());
      print(onError.toString());
    });
  }

  void getPopular({
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(GetPopularLoadingState());
    DioHelper.getData(
      url: ApiUrl.popularActivity,
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        gallery = Gallary.fromJson(value.data);
        print(value.data);
        print("Popular Get Successfully !");
        onSuccess!();
      } else {
        print("Popular get Error !");
        onError!();
      }
      emit(GetPopularSuccessState());
    }).catchError((e) {
      emit(GetPopularErrorState());
      print(e.toString());
    });
  }

  void getLocationActivities({required int locationId}) {
    emit(GetLocationActivitiesLoadingState());
    DioHelper.getData(
        url: ApiUrl.activity,
        token: token,
        query: {'locationId': locationId}).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        print('This Data : ${value.data}');
        print('Get Locations Done');
      }
      emit(GetLocationActivitiesSuccessState());
    }).catchError((onError) {
      emit(GetLocationActivitiesErrorState());
      print(onError.toString());
    });
  }

  void getCategoriesActivities({required int categoryId}) {
    emit(GetCategoryActivitiesLoadingState());
    DioHelper.getData(
        url: ApiUrl.activity,
        token: token,
        query: {'categoryId': categoryId}).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        print('This Data : ${value.data}');
        print('Get Catgories ActivitiesDone');
      }
      emit(GetCategoryActivitiesSuccessState());
    }).catchError((onError) {
      emit(GetCategoryActivitiesErrorState());
      print(onError.toString());
    });
  }

  Recommendation? recommendation;

  void getRecommendations() {
    emit(GetRecommendationsLoadingState());
    DioHelper.getData(
      url: ApiUrl.recommend +
          '${CacheHelper.getData(key: 'currentActivityId')??1}'
              '/recommend',
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        recommendation = Recommendation.fromJson(value.data);
        print('This Data : ${value.data}');
        print('Get Recommendations ActivitiesDone');
      }
      emit(GetRecommendationsSuccessState());
    }).catchError((onError) {
      emit(GetRecommendationsErrorState());
      print(onError.toString());
    });
  }
}
