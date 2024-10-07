import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/screens/home/activity_screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Home/home_cubit.dart';
import 'package:zoom_travel/shared/components/components.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

class categoryScreen extends StatelessWidget {
  categoryScreen({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getCategoriesActivities(categoryId: id),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  title,
                  style: GoogleFonts.akayaKanadaka(
                    color: Colors.white,
                    fontSize: 30.sp,
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xD3009578),
                elevation: 0,
              ),
              body: state is GetCategoryActivitiesLoadingState
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 80),
                        child: CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          colors: [Color(0xD3009578), Colors.white],
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        ActivityScreen(
                                            activity: cubit.generalActivities!
                                                .content.activities[index]));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(30))),
                                          child: Image.network(
                                            ApiUrl.baseUrlImage +
                                                cubit
                                                    .generalActivities!
                                                    .content
                                                    .activities[index]
                                                    .displayImage,
                                            fit: BoxFit.fill,
                                            width: .9.sw,
                                            height: .23.sh,
                                            headers: {
                                              "Authorization": "Bearer $token",
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
                                                  width: .9.sw,
                                                  height: .23.sh,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 2.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cubit.generalActivities!.content
                                                    .activities[index].name,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.sp,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    cubit
                                                        .generalActivities!
                                                        .content
                                                        .activities[index]
                                                        .rating
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11.sp),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 15.sp,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w,vertical: 10.h),
                                          child: Column(
                                            children: [
                                              Text(
                                                  cubit
                                                      .generalActivities!
                                                      .content
                                                      .activities[index]
                                                      .description,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 10.w,
                                height: 10.h,
                              ),
                              itemCount:
                              cubit
                                  .generalActivities!.content.activities.length
                              ,
                            ),
                          ),
                        ],
                      ),
                    ));
        },
      ),
    );
  }
}
