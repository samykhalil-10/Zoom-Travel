import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoom_travel/shared/Model/Activities/activities_model.dart';
import 'package:zoom_travel/shared/Model/gallary_model.dart';
import 'package:zoom_travel/shared/network/end_points.dart';
import 'package:zoom_travel/shared/network/remote/dio_helper.dart';

import '../../components/constants.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  static ExploreCubit get(context) => BlocProvider.of(context);

  // Latest? latest;
  GeneralActivities? generalActivities;
  Gallary? gallery;

  void getNewestAvitities({
    Function()? onError,
    Function()? onSuccess,
  }) async{
    emit(GetNewLoadingState());
    DioHelper.getData(
      url: ApiUrl.latestActivity,
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        gallery = Gallary.fromJson(value.data);
        print(value.data);
        print("Newets Get Successfully !");
        onSuccess!();
      } else {
        print("Newest get Error !");
        onError!();
      }
      emit(GetNewSuccessState());
    }).catchError((e) {
      emit(GetNewErrorState());
      print(e.toString());
    });
  }

  void getBestDeals({
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(GetBestLoadingState());
    DioHelper.getData(
      url: ApiUrl.bestDeals,
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        gallery = Gallary.fromJson(value.data);
        print(value.data);
        print("Best Deals Get Successfully !");
        onSuccess!();
      } else {
        print("Best deals get Error !");
        onError!();
      }
      emit(GetBestSuccessState());
    }).catchError((e) {
      emit(GetBestErrorState());
      print(e.toString());
    });
  }

  void getNearBy({
    Function()? onError,
    Function()? onSuccess,
  }) {
    emit(GetNearByLoadingState());
    DioHelper.getData(
      url: ApiUrl.nearby,
      token: token,
      query: {
        "longitude": long!,
        "latitude": lat!,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        generalActivities = GeneralActivities.fromJson(value.data);
        gallery = Gallary.fromJson(value.data);
        print(value.data);
        print("Near Get Successfully !");
        onSuccess!();
      } else {
        print("Near get Error !");
        onError!();
      }
      emit(GetNearBySuccessState());
    }).catchError((e) {
      emit(GetNearByErrorState());
    });
  }

}
