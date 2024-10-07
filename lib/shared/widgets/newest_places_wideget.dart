import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_travel/screens/home/activity_screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Explore/explore_cubit.dart';
import 'package:zoom_travel/shared/components/components.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

import '../components/constants.dart';

class NewestList extends StatelessWidget {
  const NewestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit()..getNewestAvitities(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ExploreCubit.get(context);
          return Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  colors: [Color(0x9578), Colors.white],
                ),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20)),
            child: cubit.generalActivities == null
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                          splashColor: ConstColors.defaultColor,
                          onTap: () {
                            navigateTo(
                                context,
                                ActivityScreen(
                                  activity: cubit.generalActivities!.content
                                      .activities[index],
                                ));
                          },
                          child: Row(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  children: [
                                    Image.network(
                                      ApiUrl.baseUrlImage +
                                          cubit.generalActivities!.content
                                              .activities[index].displayImage,
                                      fit: BoxFit.cover,
                                      width: 90.w,
                                      height: 90.h,
                                      headers: {
                                        "Authorization":
                                            "Bearer $token",
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "assets/images/popular.png",
                                            width: 90.w,
                                            height: 90.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -20,
                                      left: -20,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 20.h,
                                            right: index >= 9 ? 5.w : 8.w),
                                        alignment: Alignment.centerRight,
                                        height: 50.h,
                                        width: 50.h,
                                        decoration: BoxDecoration(
                                            color: ConstColors.defaultColor,
                                            shape: BoxShape.circle),
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                index >= 9 ? 14.sp : 18.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                height: 90.h,
                                width: .5.sw,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        cubit.generalActivities!.content
                                            .activities[index].description,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.generalActivities!.content
                                            .activities[index].name,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15.h,
                        ),
                    itemCount:
                        cubit.generalActivities!.content.activities.length),
          );
        },
      ),
    );
  }
}
