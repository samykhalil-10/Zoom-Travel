import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/App%20Controllers/Explore/explore_cubit.dart';
import 'package:zoom_travel/shared/App%20Controllers/Favourite/favourite_cubit.dart';
import 'package:zoom_travel/shared/Model/favourite_model.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

import '../../screens/home/activity_screen.dart';
import '../components/components.dart';

class FavItem extends StatelessWidget {
  const FavItem({
    Key? key,
    required this.favorites,
    required this.index,
  }) : super(key: key);
  final Wishlist favorites;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit()..getNewestAvitities(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (context, state) {},
        builder: (context, state) {
          ExploreCubit cubit = ExploreCubit.get(context);
          return InkWell(
            onTap: () {
              state is GetNewLoadingState
                  ? Center(child: CircularProgressIndicator())
                  : navigateTo(
                      context,
                      ActivityScreen(
                        activity:
                            cubit.generalActivities!.content.activities[index],
                      ));
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  width: .5.sw,
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
                            ApiUrl.baseUrlImage + favorites.displayImage!,
                            height: .15.sh,
                            width: .45.sw,
                            fit: BoxFit.cover,
                            headers: {'Authorization': 'Bearer $token'},
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  "assets/images/popular.png",
                                  height: .15.sh,
                                  width: .45.sw,
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
                              favorites.aDescription!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              favorites.aName!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocConsumer<FavouriteCubit, FavouriteState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = context.read<FavouriteCubit>();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: CircleBorder(),
                        elevation: 10,
                        child: InkWell(
                          onTap: () {
                            cubit.deleteFavourite(
                                activity_id: favorites.aId!,
                                onSuccess: () {
                                  cubit.favourite!.content!.wishlist!
                                      .removeAt(index);
                                });
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 13,
                              child: Icon(
                                Icons.favorite,
                                size: 23,
                                color: Colors.red,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
