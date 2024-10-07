import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_travel/shared/App%20Controllers/GalleryImages/gallery_images_cubit.dart';
import 'package:zoom_travel/shared/Model/Activities/activities_model.dart';
import 'package:zoom_travel/shared/components/constants.dart';
import 'package:zoom_travel/shared/components/default_button.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

import '../../shared/App Controllers/Favourite/favourite_cubit.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({Key? key, required this.activity}) : super(key: key);
  final Activities activity;

  @override
  Widget build(BuildContext context) {
    print(activity.isFavorite);
    return BlocProvider(
      create: (context) =>
          GallaryImagesCubit()..getGalleryImages(id: activity.id),
      child: BlocConsumer<GallaryImagesCubit, GallaryImagesState>(
        listener: (context, state) {},
        builder: (context, state) {
          GallaryImagesCubit cubit = context.read<GallaryImagesCubit>();
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, r) {
                            cubit.changeCarouselIndex(index);
                          },
                          autoPlay: true,
                          height: .4.sh,
                          viewportFraction: 1.2,
                        ),
                        items: cubit.images.map((path) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: cubit.images.first.contains('assets')
                                    ? Image.asset(
                                        cubit.images[cubit.carouselIndex],
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        ApiUrl.baseUrlImage +
                                            cubit.images[cubit.carouselIndex],
                                        fit: BoxFit.fill,
                                        headers: {
                                          'Authorization': 'Bearer $token'
                                        },
                                      ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: cubit.images.map((e) {
                            int index = cubit.images.indexOf(e);
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                              ),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: cubit.carouselIndex == index
                                    ? ConstColors.defaultColor
                                    : Colors.white.withOpacity(.5),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: .32.sh),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Card(
                                shape: CircleBorder(),
                                elevation: 10,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: Icon(
                                      Icons.chevron_left,
                                      size: 30.sp,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                            BlocProvider(
                              create: (context) => FavouriteCubit(),
                              child:
                                  BlocConsumer<FavouriteCubit, FavouriteState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  FavouriteCubit favCubit =
                                      FavouriteCubit.get(context);
                                  return InkWell(
                                    onTap: () {
                                      if (!activity.isFavorite) {
                                        favCubit.addFavourite(
                                            activity_id: activity.id,
                                            onSuccess: () {
                                              favCubit.changeFavState();
                                            });
                                      } else {
                                        favCubit.deleteFavourite(
                                            onSuccess: () {
                                              favCubit.changeFavState();
                                            },
                                            activity_id: activity.id);
                                      }
                                    },
                                    child: Card(
                                      shape: CircleBorder(),
                                      elevation: 10,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: Icon(
                                            activity.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: activity.isFavorite
                                                ? Colors.red
                                                : Colors.black,
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: .38.sh),
                    padding: EdgeInsets.all(15),
                    width: 1.sw,
                    height: .6.sh,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.name,
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '${activity.rating}',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => getLocation(
                                DLat: activity.lat, DLong: activity.lng),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  size: 35,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    activity.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.akayaKanadaka(
                                        color: Colors.grey[600],
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: .02.sh,
                          ),
                          Text(
                            activity.description,
                            style: GoogleFonts.akayaKanadaka(
                              fontWeight: FontWeight.w500,
                              fontSize: 25.sp,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultButton(
                              width: 200.sw,
                              height: 50.h,
                              radius: 20,
                              function: () {
                                reserveActivity(activity.redirectUrl);
                              },
                              text: 'Reserve',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
