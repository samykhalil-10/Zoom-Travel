import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoom_travel/screens/Explore/Explore_Screen.dart';
import 'package:zoom_travel/screens/Favourite/Favourite_Screen.dart';
import 'package:zoom_travel/screens/Trips/Trips_Screen.dart';
import 'package:zoom_travel/screens/home/Home_Screen.dart';
import 'package:zoom_travel/shared/cubit/states.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';

import '../../screens/Profile/Profile_Screen.dart';

class ZoomCubit extends Cubit<ZoomStates> {
  ZoomCubit() : super(ZoomInitialState());
  static ZoomCubit get(context) => BlocProvider.of(context);

  ///layout logic
  int currentIndex = 0;
  List<Widget> BottomScreens = [
    HomeScreen(),
    ExploreScreen(),
    FavouriteScreen(),
    TripsScreen(),
    ProfileScreen(),
  ];
  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ZoomChangeBottomState());
  }

  bool showPassword = true;
  bool showConfirmPassword = true;

  void switchPasswordVisibility() {
    showPassword = !showPassword;
    emit(SwitchPasswordVisibilityState());
  }

  void switchConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    emit(SwitchConfirmPasswordVisibilityState());
  }

  Position? _currentPosition;
  Future<void> getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      _currentPosition = position;
      print("lat ${_currentPosition!.latitude} -- long ${_currentPosition!.longitude}");
      if (_currentPosition != null) {
        CacheHelper.saveData(key: "lat", value: _currentPosition!.latitude);
        CacheHelper.saveData(key: "long", value: _currentPosition!.longitude);
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
