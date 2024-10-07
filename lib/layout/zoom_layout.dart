import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_travel/shared/cubit/cubit.dart';
import 'package:zoom_travel/shared/cubit/states.dart';
import 'package:zoom_travel/shared/network/local/cache_helper.dart';
import 'package:zoom_travel/shared/styles/color.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CacheHelper.saveData(key: "firstTime", value: false);
    return BlocConsumer<ZoomCubit, ZoomStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = ZoomCubit.get(context);
        return Scaffold(
          body: cubit.BottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  cubit.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: cubit.currentIndex == 0 ? defaultColor : Colors.black,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  cubit.currentIndex == 1
                      ? Icons.explore
                      : Icons.explore_outlined,
                  color: cubit.currentIndex == 1 ? defaultColor : Colors.black,
                  size: 30,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  cubit.currentIndex == 2
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: cubit.currentIndex == 2 ? defaultColor : Colors.black,
                  size: 30,
                ),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  cubit.currentIndex == 3
                      ? Icons.location_on
                      : Icons.location_on_outlined,
                  color: cubit.currentIndex == 3 ? defaultColor : Colors.black,
                  size: 30,
                ),
                label: 'Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  cubit.currentIndex == 4 ? Icons.person : Icons.person_outline,
                  color: cubit.currentIndex == 4 ? defaultColor : Colors.black,
                  size: 30,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
