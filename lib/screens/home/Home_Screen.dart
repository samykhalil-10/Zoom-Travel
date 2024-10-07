import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/screens/home/search_screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Home/home_cubit.dart';
import 'package:zoom_travel/shared/components/components.dart';
import 'package:zoom_travel/shared/widgets/Activities_list.dart';
import 'package:zoom_travel/shared/widgets/category_card.dart';
import 'package:zoom_travel/shared/widgets/recommendation_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: .03.sh),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF009578),
            Color(0xFFC8CCBE),
          ],
          begin: Alignment.topRight,
          stops: [
            0,
            .5,
          ],
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, SearchScreen());
            },
            child: Container(
              margin: EdgeInsets.only(top: .042.sh),
              height: .07.sh,
              width: .9.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 35.sp,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Places, Hotels , Transport",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryItem(
                      icon: 'assets/icons/temple.svg', text: "Historical"),
                  CategoryItem(
                      icon: 'assets/icons/restaurant.svg', text: "Restaurants"),
                  CategoryItem(icon: 'assets/icons/hotel.svg', text: "Hotels"),
                  CategoryItem(icon: 'assets/icons/cafe.svg', text: "Cafe"),
                  CategoryItem(
                      icon: 'assets/icons/railway.svg',
                      text: "Transport",
                      isTransport: true),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.h, left: 5.w),
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: BlocProvider(
                create: (context) => HomeCubit()
                  ..getPopular()
                  ..getRecommendations(),
                child: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    HomeCubit cubit = HomeCubit.get(context);
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Popular Activities",
                              style: GoogleFonts.poppins(fontSize: 18.sp),
                            ),
                          ),
                          cubit.generalActivities == null
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 80),
                                    child: CircularProgressIndicator(
                                      color: Colors.teal,
                                    ),
                                  ),
                                )
                              : ActivityList(
                                  activities: cubit
                                      .generalActivities!.content.activities,
                                  direction: Axis.horizontal),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Recommended Places',
                              style: GoogleFonts.poppins(fontSize: 18.sp),
                            ),
                          ),
                          state is GetRecommendationsLoadingState ?
                          Column(
                            children: const [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 80),
                                  child: CircularProgressIndicator(
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ],
                          ):
                          cubit.recommendation == null
                              ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 80.0),
                            child: Center(
                                child: Text(
                                  'No Recommendations',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,fontSize: 20),
                                )),
                          )
                              : RecommendationList(
                                  recommendations:
                                      cubit.recommendation!.recommendations,
                                  direction: Axis.horizontal),
                          // Center(
                          //     child: DefaultButton(
                          //   function: () {},
                          //   text: "See more",
                          //   width: .95.sw,
                          //   gradient: null,
                          //   height: 40.h,
                          //   borderColor: Colors.black,
                          //   background: Colors.white,
                          //   textColor: Colors.black,
                          //   radius: 10,
                          // )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
