import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/screens/home/recommendation_screen.dart';
import 'package:zoom_travel/shared/App%20Controllers/Home/home_cubit.dart';
import 'package:zoom_travel/shared/Model/recoomendation_model.dart';
import 'package:zoom_travel/shared/components/components.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList(
      {Key? key, required this.direction, required this.recommendations})
      : super(key: key);
  final Axis direction;
  final List<Recommendations> recommendations;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return SizedBox(
          height: direction == Axis.horizontal ? .28.sh : null,
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(direction == Axis.horizontal ? 0 : 15),
              scrollDirection: direction,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          RecommendationScreen(
                              recommendations: cubit
                                  .recommendation!.recommendations[index]));
                    },
                    child: SizedBox(
                      width: .45.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                ApiUrl.baseUrlImage +
                                    recommendations[index].displayImage,
                                height: direction == Axis.horizontal
                                    ? .15.sh
                                    : .28.sh,
                                width: direction == Axis.horizontal
                                    ? .45.sw
                                    : .9.sw,
                                fit: BoxFit.cover,
                                headers: {'Authorization': 'Bearer $token}'},
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset(
                                      "assets/images/popular.png",
                                      width: .45.sw,
                                      height: .15.sh,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recommendations[index].name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  recommendations[index].description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: direction == Axis.horizontal
                                          ? 12.sp
                                          : 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    width: 10.w,
                  ),
              itemCount: recommendations.length),
        );
      },
    );
  }
}
